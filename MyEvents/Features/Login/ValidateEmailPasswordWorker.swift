//
//  ValidateEmailPasswordWorker.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//


import Foundation

struct meValidateEmailPasswordWorker: knWorker {
    
    var email: String
    var password: String
    
    var completion: ((knError?) -> Void)?
    
    func execute() {
        
        if email.isEmpty == true {
            completion?(knError(code: knErrorCode.emptyEmail, message: "Email can't be empty"))
            return
        }
        
        if email.isValidEmail() == false {
            completion?(knError(code: knErrorCode.invalidEmail, message: "Invalid Email"))
            return
        }
        
        if password.isEmpty == true {
            completion?(knError(code: knErrorCode.emptyPassword, message: "Password can't be empty"))
            return
        }
        
        if password.length < 6 {
            completion?(knError(code: knErrorCode.invalidPassword, message: "Password must be greater than 6 characters"))
            return
        }
        
        completion?(nil)
        
    }
    
}


