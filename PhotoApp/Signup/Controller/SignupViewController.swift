//
//  SignupViewController.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-24.
//

import UIKit

class SignupViewController: UIViewController {
        
    @IBOutlet weak var usersFirstNameTextField: UITextField!
    @IBOutlet weak var usersLastNameTextField: UITextField!
    @IBOutlet weak var usersEmailTextField: UITextField!
    @IBOutlet weak var usersPasswordTextField: UITextField!
    @IBOutlet weak var usersRepeatPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var signupPresenter: SignupPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        #if DEBUG
//        if CommandLine.arguments.contains("-skipSurvey") {
//            print("Skipping survey page")
//        }
//        #endif
//        
//        
//        //More Deeper or professional
//        #if DEBUG
//        if ProcessInfo.processInfo.arguments.contains("-skipSurvey") {
//            print("Skipping survey page")
//        }
//        #endif
        
        
        if signupPresenter == nil {
            let signupModelValidator = SignupFormModelValidator()
            
            let signupUrl = ProcessInfo.processInfo.environment["signupUrl"] ?? SignupConstants.signupURLString
            
            let signupWebService = SignupWebService(urlString: signupUrl)
            
//            let signupWebService = SignupWebService(urlString: SignupConstants.signupURLString)
            
            signupPresenter = SignupPresenter(formModelValidator: signupModelValidator, webservice: signupWebService, delegate: self)
        }
        
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        let signupFormModel = SignupFormModel(firstName: usersFirstNameTextField.text ?? "",
                                              lastName: usersLastNameTextField.text ?? "",
                                              email: usersEmailTextField.text ?? "",
                                              password: usersPasswordTextField.text ?? "",
                                              repeatPassword: usersRepeatPasswordTextField.text ?? "")
        signupPresenter?.processUserSignup(formModel: signupFormModel)
    }
    
    
}

extension SignupViewController: SignupViewDelegateProtocol {
    func successfulSignup() {
        let alertController = UIAlertController(title: "Success", message: "The signup opertaion was successful", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func errorHandler(error: SignupError) {
        let alertController = UIAlertController(title: "Error", message: "Your request could not be processed at this time", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
}
