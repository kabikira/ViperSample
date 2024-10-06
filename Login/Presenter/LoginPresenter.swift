//
//  LoginPresenter.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import Foundation

public protocol LoginPresentation: AnyObject {
  func viewDidLoad()
  func tapLoginButton()
}

public final class LoginPresenter {
  private weak var view: LoginView?
  private let router: LoginWireframe
  private let interactor: LoginUsecase

  init(
    view: LoginView,
    interactor: LoginUsecase,
    router: LoginWireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension LoginPresenter: LoginPresentation {
    public func viewDidLoad() {
  }

    public func tapLoginButton() {
    router.showWeb(url: interactor.loginURL)
  }
}
