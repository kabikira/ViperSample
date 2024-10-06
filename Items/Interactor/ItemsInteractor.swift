//
//  ItemsInteractor.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/06.
//

import Foundation

public protocol ItemsUsecase {
  func getAuthenticatedUserItems(completion: ((Result<[QiitaItemEntity], Error>) -> Void)?)
  func remoteAccessToken()
}

final class ItemsInteractor {
  let api: APIClient
  init(api: APIClient = API.shared) {
    self.api = api
  }
}

extension ItemsInteractor: ItemsUsecase {
  func getAuthenticatedUserItems(completion: ((Result<[QiitaItemEntity], Error>) -> Void)? = nil) {
    api.getAuthenticatedUserItems(completion: completion)
  }

  func remoteAccessToken() {
    UserDefaults.standard.qiitaAccessToken = ""
  }
}
