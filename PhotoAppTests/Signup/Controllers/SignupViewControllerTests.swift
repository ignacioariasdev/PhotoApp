//
//  SingupViewControllerTests.swift
//  PhotoAppTests
//
//  Created by Ignacio Arias on 2021-01-24.
//

import XCTest
@testable import PhotoApp

class SignupViewControllerTests: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: SignupViewController!
    
    override func setUpWithError() throws {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SignupViewController") as? SignupViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        storyboard = nil
        sut = nil
    }

    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        
        // XCTUnwrap help us to unwrap by provding a friendly text message
        let firstNameTextField = try XCTUnwrap(sut.usersFirstNameTextField, "The firstNameTextField is not connected to an IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut.usersLastNameTextField, "The lastNameTextField is not connected to an IBOutlet")
        let emailTextField = try XCTUnwrap(sut.usersEmailTextField, "The emailTextField is not connected to an IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.usersPasswordTextField, "The passwordTextField is not connected to an IBOutlet")
        let repeatedPasswordTextField = try XCTUnwrap(sut.usersRepeatPasswordTextField, "The repeatedPasswordTextField is not connected to an IBOutlet")
        
        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view controller initially loaded")
        XCTAssertEqual(lastNameTextField.text, "", "Last name text field was not empty when the view controller initially loaded")
        XCTAssertEqual(emailTextField.text, "", "Email text field was not empty when the view controller initially loaded")
        XCTAssertEqual(passwordTextField.text, "", "Password text field was not empty when the view controller initially loaded")
        XCTAssertEqual(repeatedPasswordTextField.text, "", "Repeat password text field was not empty when the view controller initially loaded")
    }
    
    func testViewController_WhenCreated_HasSignupButtonAndAction() throws {
        //Arrange
        let signupButton: UIButton = try XCTUnwrap(sut.signupButton, "Signup button does not have a reference object")
        
        //Act
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "Signup button does not have any actions assigned to it")
        
        //Assert
        XCTAssertEqual(signupButtonActions.count, 1)
        XCTAssertEqual(signupButtonActions.first, "signupButtonTapped:", "There is no action with name signupButtonTapped assigned to signup button")
    }
    
    func testViewController_WhenSignupButtonTapped_InvokesSignupProcess() {
        //Arrange
        let mockSignupModelValidator = MockSignupModelValidator()
        let mockSignupWebService = MockSignupWebService()
        let mockSignupViewDelegate = MockSignupViewDelegate()
        
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: mockSignupModelValidator, webservice: mockSignupWebService, delegate: mockSignupViewDelegate)
        
        sut.signupPresenter = mockSignupPresenter
        
        //Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        //Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled, "The processUserSignup() method was not called on a Presenter object when the signup button was tapped in a SignupViewController")
    }

}
 
