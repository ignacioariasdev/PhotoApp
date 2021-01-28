//
//  SignupFormModelValidator.swift
//  PhotoAppTests
//
//  Created by Ignacio Arias on 2021-01-21.
//

import XCTest
@testable import PhotoApp

class SignupFormModelValidatorTests: XCTestCase {
    
    var sut: SignupFormModelValidator!

    override func setUpWithError() throws {
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        //Releasing resources
        sut = nil
    }
    
    // MARK: - First Name
    func testSignFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        
        // Arrange - Given - Inputs:
        
        // Act - When:
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Ignacio")
        
        // Assert - Then:
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have returned TRUE, but returned FALSE")
        
    }
    
    func testSignupFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        
        // Arrange - Given - Inputs:
        
        
        // Act - When:
        let isFirstNameValid = sut.isFirstNameValid(firstName: "S")
        
        // Assert - Then:
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is shorter than \(SignupConstants.firstNameMinLength) characters, but returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        
        let isFirstNameValid = sut.isFirstNameValid(firstName: "IgnacioAriasMora")
        
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is longer than \(SignupConstants.firstNameMaxLength) characters but it has returned TRUE")
    }
    
    
    // MARK: - Last Name
    func testSignupFormModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
        
        let isLastNameValid = sut.isLastNameValid(lastName: "Arias")
        
        XCTAssertTrue(isLastNameValid, "The isLastNameValid() should have returned TRUE, but returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        
        let isLastNameValid = sut.isLastNameValid(lastName: "A")
        
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have returned FALSE, but returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        let isLastNameValid = sut.isLastNameValid(lastName: "AriasAriasArias")
        
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have returned FALSE, but it returned TRUE")
    }
    
    // MARK: - Email
    func testSignupFormModelValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        let isValidEmailFormat = sut.isValidEmailFormat(email: "test@test.com")
        
        XCTAssertTrue(isValidEmailFormat, "Provided valid email address format but validation did not pass")
    }
    
    func testSignupFormModelValidator_WhenInValidEmailProvided_ShouldReturnFalse() {
        let isValidEmailFormat = sut.isValidEmailFormat(email: "test@test")
        
        XCTAssertFalse(isValidEmailFormat, "Provided invalid email address format but validation still passed")
    }
    
    // MARK: - Password
    func testSignupFormModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        let isPasswordValid = sut.isPasswordValid(password: "123456")
        
        XCTAssertTrue(isPasswordValid, "The isPasswordValid() should return TRUE, but it returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        let isPasswordValid = sut.isPasswordValid(password: "a")
        
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should return FALSE when the password is less than \(SignupConstants.passwordMinLength), but it returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        let isPasswordValid = sut.isPasswordValid(password: "123456789012345678901234567890")
        
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should return FALSE when the password contain less than \(SignupConstants.passwordMaxLength) characters, but it returned TRUE")
    }
    
    
    func testSignupFormModelValidtaor_WhenEqualPasswordsProvided_ShouldReturnTrue() {
               
        // Act - When:
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "12345678")
    
        
        // Assert - Then:
        XCTAssertTrue(doPasswordsMatch, "The doPasswordsMatch() should return TRUE, but it returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenNotMatchingPasswordsProvided_ShouldreturnFalse() {
        let isPasswordValid = sut.doPasswordsMatch(password: "123467", repeatPassword: "123456789")
        
        XCTAssertFalse(isPasswordValid, "The doPasswordsMatch() Should return FALSE for passwords that do not match, but it returned TRUE")
    }
    
}
















