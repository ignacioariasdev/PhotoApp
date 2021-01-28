//
//  SignupFormRequestModel.swift
//  PhotoApp
//
//  Created by Ignacio Arias on 2021-01-23.
//

import Foundation

//Will be encoded to json endpoint and send to webservice

struct SignupFormRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
