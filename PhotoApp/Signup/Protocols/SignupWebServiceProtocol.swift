//
//  SignupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-24.
//

import Foundation

protocol SignupWebServiceProtocol {
     
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
