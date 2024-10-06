//
//  API.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import Foundation
import Alamofire

public enum APIError: Error {
    case postAccessToken
    case getAuthenticatedUserItems
}

public protocol APIClient: AnyObject {
    var oAuthURL: URL { get }
    func postAccessToken(code: String, completion: ((Result<AccessTokenEntity, Error>) -> Void)?)
    func getAuthenticatedUserItems(completion: ((Result<[QiitaItemEntity], Error>) -> Void)?)
}

public final class API {
    static let shared = API()
    private init() {}

    private let host = "https://qiita.com/api/v2"
    private let clientID = "459805dbc32e8d12d9e9f544db0bd5a36074650d"
    private let clientSecret = "57673417cc5f73efbfd72e82b25239eb8c898a5d"
    let qiitState = "bb17785d811bb1913ef54b0a7657de780defaa2d"

    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    enum URLParameterName: String {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case scope = "scope"
        case state = "state"
        case code = "code"
    }
}

extension API: APIClient {

    public var oAuthURL: URL {
        let endPoint = "/oauth/authorize"
        return URL(string: host + endPoint + "?" +
                    "\(URLParameterName.clientID.rawValue)=\(clientID)" + "&" +
                    "\(URLParameterName.scope.rawValue)=read_qiita+write_qiita" + "&" +
                    "\(URLParameterName.state.rawValue)=\(qiitState)")!
    }

    public func postAccessToken(code: String, completion: ((Result<AccessTokenEntity, Error>) -> Void)? = nil) {
        let endPoint = "/access_tokens"
        guard let url = URL(string: host + endPoint) else {
            completion?(.failure(APIError.postAccessToken))
            return
        }

        let parameters = [
            URLParameterName.clientID.rawValue: clientID,
            URLParameterName.clientSecret.rawValue: clientSecret,
            URLParameterName.code.rawValue: code
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding(destination: .queryString))
            .responseDecodable(of: AccessTokenEntity.self, decoder: API.jsonDecoder) { response in
                switch response.result {
                case .success(let accessToken):
                    print(accessToken)
                    completion?(.success(accessToken))
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
    }

    public func getAuthenticatedUserItems(completion: ((Result<[QiitaItemEntity], Error>) -> Void)? = nil) {
        let endPoint = "/authenticated_user/items"
        guard let url = URL(string: host + endPoint),
              UserDefaults.standard.qiitaAccessToken.count > 0 else {
            completion?(.failure(APIError.getAuthenticatedUserItems))
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.qiitaAccessToken)"
        ]
        let parameters: [String: Any] = [
            "page": 1,
            "per_page": 20
        ]

        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: [QiitaItemEntity].self, decoder: API.jsonDecoder) { response in
                switch response.result {
                case .success(let items):
                    completion?(.success(items))
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
    }
}
