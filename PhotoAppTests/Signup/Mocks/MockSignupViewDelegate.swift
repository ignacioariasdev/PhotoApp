//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by Ignacio Arias on 2021-01-24.
//

import Foundation
import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {
    
    var successfulSignupCounter = 0
    var errorHandlerSignupCounter = 0
    var expectation: XCTestExpectation?
    var signupError: SignupError?
    
    func successfulSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        signupError = error
        errorHandlerSignupCounter += 1
        expectation?.fulfill()
    }
}
