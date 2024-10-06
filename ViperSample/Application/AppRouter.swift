//
//  AppRouter.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import UIKit

public protocol AppWireframe: AnyObject {
  func showLoginView()
  func showItemView()
}

public final class AppRouter {
  private let window: UIWindow

  private init(window: UIWindow) {
    self.window = window
  }

public static func assembleModules(window: UIWindow) -> AppPresentation {
    let router = AppRouter(window: window)
    let interactor = AppInteractor()
    let presenter = AppPresenter(router: router, interactor: interactor)

    return presenter
  }
}

extension AppRouter: AppWireframe {
    public func showItemView() {
    let viewController = ItemsRouter.assembleModules()
    let navigationController = UINavigationController(rootViewController: viewController)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
    public func showLoginView() {
    let viewController = LoginRouter.assembleModules()
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
}
