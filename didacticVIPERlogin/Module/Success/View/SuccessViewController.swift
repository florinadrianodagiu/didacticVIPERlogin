import UIKit

class SuccessViewController: UIViewController, SuccessViewContract {
    
    // MARK: - Properties
    var presenter: SuccessPresenterContract!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        let navigationItem = UINavigationItem(title: "Success")
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonAction))
        navigationItem.leftBarButtonItems = [backButton]
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @objc func backButtonAction() {
        presenter.goBack()
    }
}
