import Foundation

class SuccessPresenter {
    
    // MARK: - Properties
    weak var view: SuccessViewContract!
    var router: NavigationRouterContract
    
    // MARK: - Initializers
    init(view: SuccessViewContract, router: NavigationRouterContract) {
        self.view = view
        self.router = router
    }
}

extension SuccessPresenter: SuccessPresenterContract {
    
    func viewDidLoad() {
        // do something
    }
    
    func viewWillAppear() {
        // do something
    }
    
    func goBack() {
        router.getBack()
    }
}
