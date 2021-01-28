//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-24.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    
    init(formModelValidator: SignupModelValidatorProtocol, webservice: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol)
    
    func processUserSignup(formModel: SignupFormModel)
    
}
