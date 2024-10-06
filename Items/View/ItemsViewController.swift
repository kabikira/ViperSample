//
//  ItemsViewController.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/06.
//

import UIKit

public protocol ItemsView: AnyObject {
    func configure(items: [QiitaItemEntity])
    func show(error: Error)
}

final class ItemsViewController: UIViewController {

    var presenter: ItemsPresentation!

    @IBOutlet private weak var logoutButton: UIButton! {
        didSet {
          logoutButton.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
        }
    }

    private let cellID = "UITableViewCell"
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        }
    }

    private var items: [QiitaItemEntity] = []

    static func makeFromStoryboard() -> ItemsViewController {
      guard let vc = UIStoryboard(name: "Items", bundle: nil).instantiateInitialViewController() as? ItemsViewController else {
        fatalError()
      }
      return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.clearsContextBeforeDrawing = true
    }
}

private extension ItemsViewController {
  @objc func tapLogoutButton() {
    presenter.tapLogoutButton()
  }
}

extension ItemsViewController: ItemsView {
  func configure(items: [QiitaItemEntity]) {
    self.items = items
    DispatchQueue.main.async {
      self.tableView.reloadData() // 画面の更新
    }
  }

  func show(error: Error) {

  }
}


extension ItemsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = items[indexPath.row]
    presenter.selectCell(item: item)
  }
}

extension ItemsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
      fatalError()
    }

    let item = items[indexPath.row]
    cell.textLabel?.text = item.title

    return cell
  }
}
