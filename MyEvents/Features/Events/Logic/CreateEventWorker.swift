//
//  CreateEventWorker.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

struct meCreateEventWorker: knWorker {
    
    let api = "/events"
    var name: String
    var startDate: Date
    var endDate: Date
    
    var success: ((meEventModel) -> Void)?
    var fail: ((knError) -> Void)?
    
    func execute() {
        
        func requestSuccess(returnData: AnyObject) {
            success?(meEventModel(name: name,
                                  startDate: startDate.toString("MM/dd/yyyy - hh:mm"),
                                  endDate: endDate.toString("MM/dd/yyyy - hh:mm")))
        }
        
        func requestError(_ error: knError) {
            fail?(error)
        }
        
        let params = [
            "name": name,
            "startDate": startDate.timeIntervalSince1970,
            "endDate": endDate.timeIntervalSince1970
            ] as [String : Any]
        ServiceConnector.post(api, params: params,
                              success: requestSuccess, fail: requestError)
        
    }
    
}



