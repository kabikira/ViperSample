//
//  LoginViewController.swift
//  ViperSample
//
//  Created by koala panda on 2024/10/05.
//

import UIKit
import SafariServices

public protocol LoginView: AnyObject {

}
final class LoginViewController: UIViewController {
    var presenter: LoginPresentation!

    @IBOutlet private weak var qiitaOAuthButton: UIButton! {
        didSet {
          let tap: UITapGestureRecognizer = .init(target: self, action: #selector(tapOAuthButton(_:)))
          qiitaOAuthButton.addGestureRecognizer(tap)
        }
      }

      static func makeFromStoryboard() -> LoginViewController {
        guard let viewController = UIStoryboard(name: "Login", bundle: nil)
            .instantiateInitialViewController() as? LoginViewController else {
          fatalError()
        }
        return viewController
      }

      override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
      }
    }

    extension LoginViewController: LoginView {

    }

    private extension LoginViewController {
      @objc func tapOAuthButton(_ sender: UIButton) {
        presenter.tapLoginButton()
      }
    }
