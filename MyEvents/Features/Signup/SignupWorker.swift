//
//  SignupWorker.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

struct meSignupWorker: knWorker {
    
    var email: String
    var password: String
    
    var success: ((meUser) -> Void)?
    var fail: ((knError) -> Void)?
    
    func execute() {
        
        success?(meUser(profileImage: "", name: "", email: email))
        
    }
    
}
