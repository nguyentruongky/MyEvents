//
//  EventModel.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

struct meEventModel {

    var name: String?
    var startDate: String?
    var endDate: String?
    var address: String?
    var image: String?
    
    init(name: String, startDate: String, endDate: String, address: String = "Somewhere") {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        
        self.address = address
    }
    
    init(rawData: AnyObject) {
        
        name = rawData.value(forKeyPath: "name") as? String
        if let interval = rawData.value(forKeyPath: "startDate") as? String, let seconds = Double(interval) {
            let date = Date(timeIntervalSince1970: seconds)
            startDate = date.toString("MM/dd/yyyy - hh:mm")
        }
        
        if let interval = rawData.value(forKeyPath: "endDate") as? String, let seconds = Double(interval) {
            let date = Date(timeIntervalSince1970: seconds)
            endDate = date.toString("MM/dd/yyyy - hh:mm")
        }
        name = rawData.value(forKeyPath: "name") as? String
        address = "Somewhere"
    }
}
