//
//  SignupErrors.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-23.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
    
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case passwordsDoNotMatch
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidResponseModel,
             .invalidRequestURLString,
             .invalidFirstName,
             .invalidLastName,
             .invalidEmail,
             .invalidPassword,
             .passwordsDoNotMatch:
            return ""
        }
    }
    
}
