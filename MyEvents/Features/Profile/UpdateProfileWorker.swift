//
//  UpdateProfileWorker.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

struct meUpdateProfileWorker: knWorker {
    
    let api = "/profile"
    var email: String
    var name: String
    var addresses: [String]
    
    var success: (() -> Void)?
    var fail: ((knError) -> Void)?
    
    func execute() {
        
        func requestSuccess(returnData: AnyObject) {
            success?()
        }
        
        func requestError(_ error: knError) {
            fail?(error)
        }
        
        let params = [
            "email": email,
            "name": name,
            "addresses": addresses
            ] as [String : Any]
        ServiceConnector.post(api, params: params,
                              success: requestSuccess, fail: requestError)
        
    }
    
}



