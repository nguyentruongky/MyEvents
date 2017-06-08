//
//  FetchEventsWorker.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

struct meFetchEventsWorker: knWorker {
    
    let api = "/events"
    
    var success: (([meEventModel]) -> Void)?
    var fail: ((knError) -> Void)?
    
    func execute() {
        
        func requestSuccess(returnData: AnyObject) {
            print(returnData)
            
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
        
        ServiceConnector.get(api, params: nil,
                              success: requestSuccess, fail: requestError)
        
    }
    
}

