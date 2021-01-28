//
//  PhotoAppUITests.swift
//  PhotoAppUITests
//
//  Created by Ignacio Arias on 2021-01-27.
//

import XCTest

// UI tests must launch the application that they test.

/*
1. Index on the UI (normal)
2. by Placeholders
3. by accesibility identifiers (refactored to setup())
*/


//Validating that the UI elements are enabled for user interactions

//2.
//        let firstName = app.textFields["First name: "]
//        let lastName = app.textFields["Last name: "]
//        let email = app.textFields["Email: "]
//        let password = app.secureTextFields["Password:"]
//        let securePassword = app.secureTextFields["Repeat password:"]
//        let signupButton = app.staticTexts["Sign up"]

  
//po app will show identifier

class SignupFlowUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var firstName: XCUIElement!
    private var lastName: XCUIElement!
    private var email: XCUIElement!
    private var password: XCUIElement!
    private var securePassword: XCUIElement!
    private var signupButton: XCUIElement!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launchArguments = ["-skipSurvey", "-debugServer"] // Launch arguments, server stuff, command line
        app.launchEnvironment = ["signupUrl":       "http://appsdeveloperblog.com/api/v2/signup-mock-service/users",
                                 "inAppPurchasesEnabled":"true",
                                 "inAppAdsEnabled":"true"] // Test server
        app.launch()
        
        //3.
        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailAddressTextField"]
        password = app.secureTextFields["passwordTextField"]
        securePassword = app.secureTextFields["repeatPasswordTextField"]
        signupButton = app.buttons["signupButton"]

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        firstName = nil
        lastName = nil
        email = nil
        password = nil
        securePassword = nil
        signupButton = nil
        
        try super.tearDownWithError()
    }

    func testSignupViewController_WhenViewLoaded_RequiredUIElementsAreEnabled() throws {
      
        XCTAssertTrue(firstName.isEnabled, "First name UITextField is not enabled for user interactions")
        XCTAssertTrue(lastName.isEnabled, "Last name UITextField is not enabled for user interactions")
        XCTAssertTrue(email.isEnabled, "Email UITextField is not enabled for user interactions")
        XCTAssertTrue(password.isEnabled, "Password UITextField is not enabled for user interactions")
        XCTAssertTrue(securePassword.isEnabled, "Secure password UITextField is not enabled for user interactions")
        XCTAssertTrue(signupButton.isEnabled, "Signup button is not enabled for user interactions")
    }
    
    func testViewController_WhenInvalidFormSubmitted_PresentsErrorAlertDialog() {
        //Arrange
        firstName.tap()
        firstName.typeText("S")
        
        lastName.tap()
        lastName.typeText("K")
        
        email.tap()
        email.typeText("@")
        
        password.tap()
        password.typeText("123456")
        
        securePassword.tap()
        securePassword.typeText("123")
        
        //Act
        signupButton.tap()
        
        //Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1.5), "An error alert dialog was not presented when invalid signup form was submitted")
    }
    
    func testViewController_WhenValidFormSubmitted_PresentsSuccessAlertDialog() {
        //Arrange
        firstName.tap()
        firstName.typeText("Ignacio")
        
        lastName.tap()
        lastName.typeText("Arias")
        
        email.tap()
        email.typeText("test@test.com")
        
        password.tap()
        password.typeText("123456789")
        
        securePassword.tap()
        securePassword.typeText("123456789")
        
        //Act
        signupButton.tap()
        
        //Assert
        
        //Watch out the timeout, it could be longer if the connection is not fast a the time.
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 1.5), "A success alert dialog was not presented when a valid signup form was submitted")
    }
    
    func testViewController_WhenValidFormSubmitted_PresentsSuccessAlertDialog_v2_WithProgrammaticScreenshots() {
        //Arrange
        firstName.tap()
        firstName.typeText("Ignacio")
        
        lastName.tap()
        lastName.typeText("Arias")
        
        email.tap()
        email.typeText("test@test.com")
        
        password.tap()
        password.typeText("123456789")
        
        securePassword.tap()
        securePassword.typeText("123456789")
        
        //Act
        signupButton.tap()
        
        // MARK: - Screenshots programmatically of the UITextField
        let emailTextFieldScreenshot = email.screenshot()
        let emailTextFieldAttachment = XCTAttachment(screenshot: emailTextFieldScreenshot)
        emailTextFieldAttachment.name = "Screenshot of Email UITextField"
        emailTextFieldAttachment.lifetime = .keepAlways
        add(emailTextFieldAttachment)
        
        
        // MARK: - Screenshot programmatically of the app window
        
        //let currentAppWindow = app.screenshot()
        
        //Also ~ same 
        let currentAppWindow = XCUIScreen.main.screenshot()
        
        
        let currentAppWindowAttachment = XCTAttachment(screenshot: currentAppWindow)
        currentAppWindowAttachment.name = "Signup page screenshot"
        currentAppWindowAttachment.lifetime = .keepAlways
        add(currentAppWindowAttachment)
        
        
        
        //Assert
        
        //Watch out the timeout, it could be longer if the connection is not fast a the time.
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 1.5), "A success alert dialog was not presented when a valid signup form was submitted")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
