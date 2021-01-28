//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by Ignacio Arias on 2021-01-23.
//

import XCTest
@testable import PhotoApp

class SignupWebServiceTests: XCTestCase {
    
    var sut: SignupWebService!
    var signFormRequestModel: SignupFormRequestModel!
    
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        signFormRequestModel = SignupFormRequestModel(firstName: "Ignacio", lastName: "Arias", email: "test@test.com", password: "12345678")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        signFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil // This one as well because it is static
        MockURLProtocol.error = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        // Arrange - Given - Inputs:
        let jsonString = "{\"status\":\"ok\"}" //Positive scenario
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act - When:
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in
            
            // Assert - Then:
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        //If a response is not within the timeInterval and the expectation: the test will fail.
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        // Arrange - Given - Inputs:
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}" //Positive scenario
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup() method expectation for a response that contains a different JSON structure")
        
        // Act - When:
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in
            
            // Assert - Then:
            XCTAssertNil(signupResponseModel, "The response model for a request containing unknown JSON response, shoulld have been nil")
            XCTAssertEqual(error, SignupError.invalidResponseModel, "The signup() method did not return expected error")
            expectation.fulfill()
        }
        //If a response is not within the timeInterval and the expectation: the test will fail.
        self.wait(for: [expectation], timeout: 5)
    }
    
    //New UT
    func testSignupWebservice_WhenEmptyURLStringProvided_ReturnsError() {
        // Given:
        let expectation = self.expectation(description: "An empty request URL String expectation")
        
        sut = SignupWebService(urlString: "")
        
        // When:
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in
            
            // Assert:
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "The signup() method did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(signupResponseModel, "When an invalidRequestURLString takes places, the response model must be nil")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        
        // Arrange:
        let expectation = self.expectation(description: "A failed Request expectation")
        let errorDescription = "A localized description of an error"
//                MockURLProtocol.error = SignupError.failedRequest(description: errorDescription)
        MockURLProtocol.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        
        // Act:
        sut.signup(withForm: signFormRequestModel) { (signupResponseModel, error) in
            // Assert:
            XCTAssertEqual(error, SignupError.failedRequest(description:errorDescription), "The signup() method did not return an expecter error for the Failed Request")
            //            XCTAssertEqual(error?.localizedDescription, errorDescription)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
}
