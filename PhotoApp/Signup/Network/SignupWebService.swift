//
//  SignupWebService.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-23.
//

import Foundation

//Will be used as a depednecy injection
class SignupWebService: SignupWebServiceProtocol {
    
    private var urlSession: URLSession
    private var urlString: String
    
    
    //By adding the urlSession, we are injecting the singleton into the init, now we can used it on the data task
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        
        guard let url = URL(string: urlString)  else {
            completionHandler(nil, SignupError.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        
        //We are going to send JsonPayload on the http request, so http method post will be ok
        request.httpMethod = "POST"
        
        //Header response back Content-Type
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Response would like to accept Json Model to accept the body
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        //Swift to Json
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        
        //Note: if we access URLSession over here, it will be an integration test rather than UT.
        //So: We will need to mock the URLSession.
        //Then: Our UT will need to inject a mock version of the URL Session
        
        //Injecting URL Session object into signupWebSErvice
//       let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in}
        
        //INJECTED:
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            //Safe unwrap
            if let requestError = error {
                completionHandler(nil, SignupError.failedRequest(description: requestError.localizedDescription))
                return
            }
            
            if let data = data, let signupResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completionHandler(signupResponseModel, nil)
            } else {
                //Todo: create a new UT to handle an eror here
                completionHandler(nil, SignupError.invalidResponseModel)
            }
         }
        
        dataTask.resume()
    }
    
}
