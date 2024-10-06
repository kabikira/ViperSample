//
//  LoginInteractor.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import Foundation

public protocol LoginUsecase {
  var loginURL: URL? { get }
}

public final class LoginInteractor {
  let api: APIClient
  init(api: APIClient = API.shared) {
    self.api = api
  }
}

extension LoginInteractor: LoginUsecase {
  public var loginURL: URL? { api.oAuthURL }
}
