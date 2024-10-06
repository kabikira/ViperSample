//
//  AppPresenter.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import Foundation

public protocol AppPresentation: AnyObject {
  func didFinishLaunch()
  func openURL(_ url: URL) -> Bool
}

public final class AppPresenter {
  private let router: AppWireframe
  private let interactor: AppUsecase

  init(router: AppWireframe, interactor: AppUsecase) {
    self.router = router
    self.interactor = interactor
    setupNotification()
  }
}

private extension AppPresenter {
  func setupNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(reStart), name: .reStart, object: nil)
  }

  @objc func reStart() {
    if interactor.isLogined {
      router.showItemView()
    } else {
      router.showLoginView()
    }
  }
}

extension AppPresenter: AppPresentation {
    public func didFinishLaunch() {
    reStart()
  }

    public func openURL(_ url: URL) -> Bool {
    guard let queryItems = URLComponents(string: url.absoluteString)?.queryItems,
          let code = queryItems.first(where: {$0.name == "code"})?.value,
          let getState = queryItems.first(where: {$0.name == "state"})?.value,
          getState == API.shared.qiitState
    else {
      return true
    }
    interactor.postAccessToken(code: code) {[weak self] (result) in
      switch result {
      case .success(_):
        self?.router.showItemView()
      case .failure(_):
        self?.router.showLoginView()
      }
    }
    return true
  }
}
