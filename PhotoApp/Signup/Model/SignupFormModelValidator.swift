//
//  SignupFormModelValidator.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-21.
//

import Foundation

class SignupFormModelValidator: SignupModelValidatorProtocol {
    
    // MARK: - First Name
    
    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true
    
        //By the moment only one validation, we could have tons of requirements
        if firstName.count < SignupConstants.firstNameMinLength || firstName.count > SignupConstants.firstNameMaxLength {
            returnValue = false
        }
        
        return returnValue
    }
    
    
    // MARK: - Last Name
    
    func isLastNameValid(lastName: String) -> Bool {
        var returnValue = true
        
        if lastName.count < SignupConstants.lastNameMinLength || lastName.count > SignupConstants.lastNameMaxLength {
            returnValue = false
        }
        
        return returnValue
    }
    
    
    
    // MARK: - Email
    func isValidEmailFormat(email: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
    
    
    // MARK: - Password
    func isPasswordValid(password: String) -> Bool {
        var returnValue = true
        
        if password.count < SignupConstants.passwordMinLength || password.count > SignupConstants.passwordMaxLength {
            returnValue = false
        }
        
        return returnValue
    }
    
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool {
        return password == repeatPassword
    }
    
    
}




















