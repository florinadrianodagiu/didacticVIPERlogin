//
//  LoginInteractor.swift
//
//  Created by Florin Adrian Odagiu on 22/01/2020.
//

import Foundation

class LoginInteractor {
    
    // MARK: - Properties
    weak var presenter: LoginPresenterContract!
    private var loginProgress: LoginProcessModel = .loginNotStartedOrSuccessfullyFinished
    
    // MARK: - Initializers
    init(presenter: LoginPresenterContract) {
        self.presenter = presenter
    }
    
    private func makeAuthenticationHappen(for email: String, and password: String) {
        print("\nLogin request started\n")
        loginProgress = .loginOngoing
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in   //for testing only: using a 3 seconds delay before making the request to allow for the Cancel button to be exercised
            if self?.loginProgress == .loginOngoing {                          //for testing only: using a 3 seconds delay before making the request to allow for the Cancel button to be exercised
                
                NetworkRequester.requestAuthentication(email: email, password: password) { [weak self] payload, somethingWrong in
                    guard let _ = payload else {
                        print("\nLogin request finished with an error\n")
                        self?.loginProgress = .loginFailed
                        self?.presenter.loginFailedWith(message: somethingWrong!)
                        return
                    }
                    
                    print("\nLogin request finished successfully\n")
                    self?.loginProgress = .loginNotStartedOrSuccessfullyFinished
                    self?.presenter.loginSucceeded()
                }
                
            }
        }
    }
    
    private func cancelAuthentication() {
        print("\nLogin request canceled\n")
        loginProgress = .loginNotStartedOrSuccessfullyFinished
    }
}



extension LoginInteractor: LoginInteractorContract {
    
    func loginProcessState() -> LoginProcessModel {
        return loginProgress
    }
    
    func loginActionRequested(for email: String, and password: String) {
        switch loginProgress {
            
            case .loginNotStartedOrSuccessfullyFinished:
                makeAuthenticationHappen(for: email, and: password)
            
            case .loginOngoing:
                cancelAuthentication()
            
            case .loginFailed:
                makeAuthenticationHappen(for: email, and: password)
            
        }
    }
    
    
}
