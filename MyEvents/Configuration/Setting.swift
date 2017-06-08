//
//  Setting.swift
//  Marco
//
//  Created by Ky Nguyen on 6/5/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

struct meSetting {
    
    static var currentUser: meUser? 
    
    static var didLogin: Bool {
//        return currentUser != nil
        return true
    }
    
    static let placeApiKey = "AIzaSyAh9IFVETKbu3srSyWFtNHl2PgToJqrKMI"
    
    static let baseUrl = ""
    static var firstController: UIViewController {
        
        let controller = didLogin == true ? meHomeManager() : UINavigationController(rootViewController: meLoginController())
        return controller
    }
    
}
