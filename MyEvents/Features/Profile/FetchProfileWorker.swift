//
//  FetchProfileWorker.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

struct meFetchProfileWorker: knWorker {
    
    let api = "/fetch_profile"
    var email: String
    
    var success: ((meUser) -> Void)?
    var fail: ((knError) -> Void)?
    
    func execute() {
        
        func requestSuccess(returnData: AnyObject) {
            print(returnData)
            
            let userRawData = returnData.value(forKeyPath: "data")
            success?(meUser(rawData: userRawData! as AnyObject))
        }
        
        func requestError(_ error: knError) {
            fail?(error)
        }
        
        ServiceConnector.post(api, params: ["email": email],
                             success: requestSuccess, fail: requestError)
        
    }
    
}

