//
//  ValidateEmailWorker.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//


import Foundation


struct meValidateEmailWorker: knWorker {
    
    var email: String
    
    var completion: ((knError?) -> Void)?
    
    func execute() {
        
        if email.isEmpty == true {
            completion?(knError(code: nil, message: "Email can't be empty"))
            return
        }
        
        if email.isValidEmail() == false {
            completion?(knError(code: nil, message: "Invalid Email"))
            return
        }
        
        completion?(nil)
        
    }
    
}


