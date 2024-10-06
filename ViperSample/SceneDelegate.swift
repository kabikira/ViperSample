import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appPresenter: AppPresentation?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // UIWindowSceneを取得
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // UIWindowの初期化
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        // AppRouterを組み立て、AppPresenterを取得
        appPresenter = AppRouter.assembleModules(window: window)

        // アプリの起動完了処理
        appPresenter?.didFinishLaunch()

        // ここいらないかも
        // windowを表示
//        window.makeKeyAndVisible()

        // 起動時にURLが渡された場合の処理
        if let urlContext = connectionOptions.urlContexts.first {
            let url = urlContext.url
            appPresenter?.openURL(url)
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // アプリが既に起動している状態でURLが渡された場合の処理
        for urlContext in URLContexts {
            let url = urlContext.url
            appPresenter?.openURL(url)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // シーンが切断されたときの処理
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // シーンがアクティブになったときの処理
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // シーンが非アクティブになる前の処理
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // シーンがフォアグラウンドに入る前の処理
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // シーンがバックグラウンドに入った後の処理
    }
}
