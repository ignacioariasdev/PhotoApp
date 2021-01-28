//
//  SignupConstants.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-21.
//

import Foundation

struct SignupConstants {
    
    // MARK: - First Name
    
    static let firstNameMinLength = 2
    static let firstNameMaxLength = 10
    
    // MARK: - Last Name
    
    static let lastNameMinLength = 2
    static let lastNameMaxLength = 10
    
    // MARK: - Password
    
    static let passwordMinLength = 2
    static let passwordMaxLength = 20
    
    
    // MARK: - Web Service
    
    // MARK: - PINFOLIST
    //Http is an insecure connection so we need to go through the info.plist
    // +, App transport Security Settings -> Allow Arbitratry Loads = YES
    static let signupURLString = "http://appsdeveloperblog.com:8080/signup-mock-service/users"
    
    //    static let anyForTestURLsignupURLString = "https://jsonplaceholder.typicode.com/"

}
