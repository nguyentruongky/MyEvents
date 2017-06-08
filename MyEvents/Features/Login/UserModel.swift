//
//  UserModel.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

class meUser {

    var id: Int = 0
    var profileImage: String
    var name: String
    var email: String

    var token: String?

    init(profileImage: String, name: String, email: String) {
        self.profileImage = profileImage
        self.name = name
        self.email = email
        id = 0
    }
}
