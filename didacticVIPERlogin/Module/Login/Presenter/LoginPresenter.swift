import Foundation

class LoginPresenter {
    
    // MARK: - Properties
    var router         : NavigationRouterContract
    weak var view      : LoginViewContract!
    lazy var interactor: LoginInteractorContract = LoginInteractor(presenter: self)
    
    var viewState      : LoginScreenModel        = LoginScreenModel(emailBorderColor        : "Black", //avoiding UIColor and inclusion of UIKit in presenter
                                                                    passwordBorderColor     : "Black", //avoiding UIColor and inclusion of UIKit in presenter
                                                                    loginButtonText         : "Login",
                                                                    loginButtonEnabled      : false,
                                                                    activityIndicatorEnabled: false,
                                                                    errorText               : ""
                                                                   )
    
    var currentEmail   : String
    var currentPassword: String
    var currentError   : String
    
    // MARK: - Initializers
    init(view: LoginViewContract, router: NavigationRouterContract) {
        self.view = view
        self.router = router
        //self.interactor = assigned in the properties section
        
        currentEmail    = ""
        currentPassword = ""
        currentError    = ""
    }
    
    
    //MARK: - UI Logic
    func figureOutUIState() {
        
        //customize email field
            if currentEmail.isEmpty {
                viewState.emailBorderColor = "Black"
            } else if validEmail(email: currentEmail) {
                viewState.emailBorderColor = "Blue"
            } else {
                viewState.emailBorderColor = "Red"
            }
        
        //customize password field
            if currentPassword.isEmpty {
                viewState.passwordBorderColor = "Black"
            } else if validPassword(password: currentPassword) {
                viewState.passwordBorderColor = "Blue"
            } else {
                viewState.passwordBorderColor = "Red"
            }
        
        //customize login button, activity indicator and error message
            switch interactor.loginProcessState() {
                
                case .loginNotStartedOrSuccessfullyFinished:
                    viewState.loginButtonText = "Login"
                    if validEmail(email: currentEmail) && validPassword(password: currentPassword) {
                        viewState.loginButtonEnabled = true
                    } else{
                        viewState.loginButtonEnabled = false
                    }
                    viewState.activityIndicatorEnabled = false
                    viewState.errorText = ""
                
                case .loginOngoing:
                    viewState.loginButtonText = "Cancel"
                    viewState.loginButtonEnabled = true
                    viewState.activityIndicatorEnabled = true
                    viewState.errorText = ""
                
                case .loginFailed:
                    viewState.loginButtonText = "Try Again"
                    viewState.loginButtonEnabled = true
                    viewState.activityIndicatorEnabled = false
                    viewState.errorText = currentError
                
            }
        
        //apply all of the above customizations
            view.apply(viewState: viewState)
    }
    
    func validEmail(email: String) -> Bool {
        if email.contains("@") && email.count >= 7 && String(email.suffix(4)) == ".com" { //assuming minimum viable password length is 7. Example: x@y.com
            return true
        }
        
        return false
    }
    
    func validPassword(password: String) -> Bool {
        if password.count >= 3 {
            return true
        }
        
        return false
    }
}

extension LoginPresenter: LoginPresenterContract {
    
    //the "reacting to stuff" part
    func viewDidLoad() {
        view.apply(viewState: viewState)
    }
    
    func viewWillAppear() {
        
    }
    
    func emailFieldUpdated(newEmailContent: String) {
        currentEmail = newEmailContent
        figureOutUIState()
    }
    
    func passwordFieldUpdated(newPasswordContent: String) {
        currentPassword = newPasswordContent
        figureOutUIState()
    }
    
    func loginButtonPressed() {
        interactor.loginActionRequested(for: currentEmail, and: currentPassword)
        figureOutUIState()
    }
    
    
    
    //the "executing stuff" part
    func loginFailedWith(message: String) {
        currentError = message
        figureOutUIState()
    }
    
    func loginSucceeded() {
        figureOutUIState()
        router.presentSuccess()
    }
}
