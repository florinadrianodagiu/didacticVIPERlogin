import Foundation

protocol LoginPresenterContract: class {
    
    //the "reacting to stuff" part
    func viewDidLoad()
    func viewWillAppear()
    
    func emailFieldUpdated(newEmailContent: String)
    func passwordFieldUpdated(newPasswordContent: String)
    
    func loginButtonPressed()
    
    
    
    //the "executing stuff" part
    func loginFailedWith(message: String)
    func loginSucceeded()
}
