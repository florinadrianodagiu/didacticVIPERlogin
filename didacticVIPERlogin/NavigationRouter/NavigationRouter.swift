import UIKit

protocol NavigationRouterContract {
    
    func presentLogin()
    func presentSuccess()
    
    func getBack()
}

class NavigationRouter {
    
    // MARK: - Properties
    private weak var window: UIWindow?
    private var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
    }

}

extension NavigationRouter: NavigationRouterContract {
    
    func presentLogin() {
        let view = mainStoryboard.instantiateInitialViewController() as! LoginViewController
        let presenter = LoginPresenter(view: view, router: self)
        view.presenter = presenter
        
        window?.rootViewController = view
    }
    
    func presentSuccess() {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "SuccessViewController") as! SuccessViewController
        let presenter = SuccessPresenter(view: view, router: self)
        view.presenter = presenter
        
        window?.rootViewController?.present(view, animated: true)
    }
    
    func getBack() {
        window?.rootViewController?.presentedViewController?.dismiss(animated: true)
    }
}
