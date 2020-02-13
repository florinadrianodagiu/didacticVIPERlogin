import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, LoginViewContract {

    // MARK: - Properties
    var presenter: LoginPresenterContract!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorTextField: UILabel!
    
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField   .layer.borderWidth = 1.0
        passwordTextField.layer.borderWidth = 1.0
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        emailTextField.text = "a@b.com"            //for testing purposes
//        passwordTextField.text = "abc"             //for testing purposes
//        dispatch(textField: emailTextField)        //for testing purposes
//        dispatch(textField: passwordTextField)     //for testing purposes
        
        presenter.viewWillAppear()
    }
    
    
    
    //MARK: - Button Actions
    @IBAction func loginButtonAction(_ sender: Any) {
        
        for view in view.subviews {
            if view.isFirstResponder {
                view.resignFirstResponder() //fold down the keyboard if the user didn't tap Done while editing the last textfield
            }
        }
        
        presenter.loginButtonPressed()
    }
    
    
    //MARK: - UITExtFieldDelegate conformancy
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        dispatch(textField: textField, accompaniedBy: string)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dispatch(textField: textField)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        dispatch(textField: textField)
        return true
    }
    
    
    
    //MARK: - LoginViewContract conformance         //shouldn't it be added in an extension, as presenter does?
    func apply(viewState: LoginScreenModel) {
        
        switch viewState.emailBorderColor {
            case "Black":
                emailTextField.layer.borderColor = UIColor.black.cgColor
            case "Red":
                emailTextField.layer.borderColor = UIColor.red.cgColor
            case "Blue":
                emailTextField.layer.borderColor = UIColor.blue.cgColor
            default:
                emailTextField.layer.borderColor = UIColor.black.cgColor
        }
        
        switch viewState.passwordBorderColor {
            case "Black":
                passwordTextField.layer.borderColor = UIColor.black.cgColor
            case "Red":
                passwordTextField.layer.borderColor = UIColor.red.cgColor
            case "Blue":
                passwordTextField.layer.borderColor = UIColor.blue.cgColor
            default:
                passwordTextField.layer.borderColor = UIColor.black.cgColor
        }
        
        loginButton.setTitle(viewState.loginButtonText, for: .normal)
        loginButton.isEnabled = viewState.loginButtonEnabled
        
        viewState.activityIndicatorEnabled ? loginActivityIndicator.startAnimating() : loginActivityIndicator.stopAnimating()
        
        errorTextField.text = viewState.errorText
    }
    
    
    //MARK: - Miscellaneous
    func dispatch(textField: UITextField, accompaniedBy lastLetter: String? = nil) {
        
        var textFieldContent =   (lastLetter == nil   ?   textField.text!   :   textField.text! + lastLetter!)
        if lastLetter == "" {
            textFieldContent.removeLast() //handle character by character delete
        }
        
        if textField == emailTextField {
            presenter.emailFieldUpdated(newEmailContent: textFieldContent)
        }
        
        if textField == passwordTextField {
            presenter.passwordFieldUpdated(newPasswordContent: textFieldContent)
        }
    }
}

