//
//  ItemsPresenter.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/06.
//

import Foundation

public protocol ItemsPresentation: AnyObject {
  func viewDidLoad()
  func selectCell(item: QiitaItemEntity)
  func tapLogoutButton()
}

final class ItemsPresenter {
  private weak var view: ItemsView?
  private let router: ItemsWireframe
  private let interactor: ItemsUsecase

  init(
    view: ItemsView,
    interactor: ItemsUsecase,
    router: ItemsWireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension ItemsPresenter: ItemsPresentation {
    func viewDidLoad() {
        interactor.getAuthenticatedUserItems { [weak self] result in
            switch result {
            case .success(let items):
                self?.view?.configure(items: items)
            case .failure(let error):
                self?.view?.show(error: error)
            }
        }
    }

  func selectCell(item: QiitaItemEntity) {
    guard let url = item.url else {
      return
    }
    router.showWeb(url: url)
  }

  func tapLogoutButton() {
    interactor.remoteAccessToken()
    router.showStart()
  }
}
