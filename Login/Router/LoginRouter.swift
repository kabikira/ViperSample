//
//  LoginRouter.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import UIKit

public protocol LoginWireframe: AnyObject {
  func showWeb(url: URL?)

}

final class LoginRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = LoginViewController.makeFromStoryboard()
    let router = LoginRouter(viewController: view)
    let interactor = LoginInteractor()
    let presenter = LoginPresenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.presenter = presenter

    return view
  }
}

extension LoginRouter: LoginWireframe {
 public func showWeb(url: URL?) {
    guard
      let _url = url,
      UIApplication.shared.canOpenURL(_url)
      else { return }
    UIApplication.shared.open(_url, options: [:], completionHandler: nil)
  }
}
