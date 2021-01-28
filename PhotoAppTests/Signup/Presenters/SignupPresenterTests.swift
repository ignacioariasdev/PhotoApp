//
//  SignupPresenderTests.swift
//  PhotoAppTests
//
//  Created by Ignacio Arias on 2021-01-24.
//

import XCTest
@testable import PhotoApp

class SignupPresenterTests: XCTestCase {
    
    var signupFormModel: SignupFormModel!
    var mockSignupModelValidator: MockSignupModelValidator!
    var mockSignupWebService: MockSignupWebService!
    var mockSignupViewDelegate: MockSignupViewDelegate!
    var sut: SignupPresenter!
    
    override func setUpWithError() throws {
        
        signupFormModel = SignupFormModel(firstName: "Ignacio",
                                              lastName: "Arias",
                                              email: "test@test.com",
                                              password: "12345678",
                                              repeatPassword: "12345678")
        
        mockSignupModelValidator = MockSignupModelValidator()
        mockSignupWebService = MockSignupWebService()
        mockSignupViewDelegate = MockSignupViewDelegate()
        
        sut = SignupPresenter(formModelValidator: mockSignupModelValidator, webservice: mockSignupWebService, delegate: mockSignupViewDelegate)
    }

    override func tearDownWithError() throws {
        //Releasing resources 
        signupFormModel = nil
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        mockSignupViewDelegate = nil
        sut = nil
    }

    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        //Arrage
        //Act
        sut.processUserSignup(formModel: signupFormModel)
        
        //Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailFormatValidated, "Email format was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordEqualityValidated, "Did not validate if passwords match")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        //Arrange
        //Act
        sut.processUserSignup(formModel: signupFormModel)
        
        //Assert
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "The signup() method was not called in the SignupWebService class")
    }
    
    
    func testSignupPresenter_WhenSignupOperationSuccessful_CallsSuccessOnViewDelegate() {
        //Arrange
        let myExpectation = expectation(description: "Expected the successfulSignup() method to be called")
        
        mockSignupViewDelegate.expectation = myExpectation
        
        //Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        //Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1, "The successful signup() method was called more than one time")
    }
    
    
    func testSignupPresenter_WhenSignupOperationFails_ShouldCallErrorHandlerOnMockSignupViewDelegate() {
        //Arrange
        let myExpectation = expectation(description: "Expected the errorHandler() to be called")
        mockSignupViewDelegate.expectation = myExpectation
        mockSignupWebService.shouldReturnError = true
        
        //Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        //Assert
        
        //Create the SignupError, not sure if we'll use Equatable
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 0)
        XCTAssertEqual(mockSignupViewDelegate.errorHandlerSignupCounter, 1)
        XCTAssertNotNil(mockSignupViewDelegate.signupError)
    }
    
    
}
