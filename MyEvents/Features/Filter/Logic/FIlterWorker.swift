//
//  FIlterWorker.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

struct meFilterWorker: knWorker {
    
    let api = "/filter"
    var name: String
    var startDate: Date
    var endDate: Date
    
    var success: (([meEventModel]) -> Void)?
    var fail: ((knError) -> Void)?
    
    func execute() {
        
        func requestSuccess(returnData: AnyObject) {
            let eventsRawData = returnData.value(forKeyPath: "events") as? [AnyObject]
            
            var events = [meEventModel]()
            for item in eventsRawData! {
                events.append(meEventModel(rawData: item))
            }
            
            success?(events)
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
