//
//  SignupWorker.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

struct meSignupWorker: knWorker {
    
    let api = "/register"
    var email: String
    var password: String
    
    var success: ((meUser) -> Void)?
    var fail: ((knError) -> Void)?
    
    func execute() {
        
        func requestSuccess(returnData: AnyObject) {
            print(returnData)
            let user = meUser(profileImage: "", name: email, email: email)
            success?(user)
        }
        
        func requestError(_ error: knError) {
            fail?(error)
        }
        
        ServiceConnector.post(api, params: ["email": email, "password": password],
                              success: requestSuccess, fail: requestError)
        
        
        
    }
    
}
