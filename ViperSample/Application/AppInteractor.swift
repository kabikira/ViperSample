//
//  AppInteractor.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import Foundation

public protocol AppUsecase {
  var isLogined: Bool { get }
  func postAccessToken(code: String, completion: ((Result<String, Error>) -> Void)?)

}

public final class AppInteractor {
  let api: APIClient
  init(api: APIClient = API.shared) {
    self.api = api
  }
}

extension AppInteractor: AppUsecase {
    public var isLogined: Bool { UserDefaults.standard.qiitaAccessToken.count > 0 }

    public func postAccessToken(code: String, completion: ((Result<String, Error>) -> Void)? = nil) {
    api.postAccessToken(code: code) { result  in
      switch result {
      case .success(let accessTokenEntity):
        UserDefaults.standard.qiitaAccessToken = accessTokenEntity.token
        completion?(.success(accessTokenEntity.token))
      case .failure(let error):
        completion?(.failure(error))
      }
    }
  }
}
