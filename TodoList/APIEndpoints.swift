//
//  APIEndpoints.swift
//  TodoList
//
//  Created by Matt Benavente on 10/20/16.
//  Copyright © 2016 Matt Benavente. All rights reserved.
//

import Foundation

class APIEndpoints {
    private static let baseURL = "http://localhost:3000/v1" //All other endpoints will stem from this baseURL
    static let signupURL = "\(baseURL)/signup"   // Now you can resplace the URL in the Alamofire request wit APIEnpoints.signupURL
    static let signinURL = "\(baseURL)/signin"
}

//Setting up an API endpoint that signs our Users in
//User POSTs their credentials to the API and they recieve back an Authentication Token
// The logic for signing in same as for signing up
