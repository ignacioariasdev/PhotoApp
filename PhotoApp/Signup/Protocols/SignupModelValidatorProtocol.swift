//
//  SignupModelValidatorProtocol.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-24.
//

import Foundation

//The mock version and the real version will implement.
protocol SignupModelValidatorProtocol {
    
    func isFirstNameValid(firstName: String) -> Bool
    func isLastNameValid(lastName: String) -> Bool
    func isValidEmailFormat(email: String) -> Bool
    func isPasswordValid(password: String) -> Bool
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool
}
