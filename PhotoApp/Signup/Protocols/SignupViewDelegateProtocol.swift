//
//  SignupViewDelegateProtocol.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-24.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func successfulSignup()
    func errorHandler(error: SignupError)
}
