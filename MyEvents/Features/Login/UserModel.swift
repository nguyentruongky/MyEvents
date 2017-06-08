//
//  UserModel.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

struct meUser {

    var id: Int = 0
    var profileImage: String?
    var name: String?
    var email: String?

    var addresses = [String]()

    init(profileImage: String, name: String, email: String) {
        self.profileImage = profileImage
        self.name = name
        self.email = email
        id = 0
    }
    
    init(rawData: AnyObject) {
        
        profileImage = ""
        name = rawData.value(forKeyPath: "name") as? String
        email = rawData.value(forKeyPath: "email") as? String
        let addressesTemp = rawData.value(forKeyPath: "addresses") as? [String]
        addresses = addressesTemp == nil ? [String]() : addressesTemp!
        
    }
}
