//
//  Setting.swift
//  Marco
//
//  Created by Ky Nguyen on 6/5/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

struct meSetting {
    
    static var currentUser: meUser? {
        didSet {
            currentUserEmail = currentUser?.email
        }
    }
    
    static var currentUserEmail: String? {
        get {
            let user = UserDefaults.standard.value(forKeyPath: "currentUserEmail") as? String
            return user
        }
        set {
            UserDefaults.standard.setValue(newValue, forKeyPath: "currentUserEmail")
        }
    }
    
    static var didLogin: Bool {
        return currentUserEmail != nil
    }
    
    static let placeApiKey = "AIzaSyAh9IFVETKbu3srSyWFtNHl2PgToJqrKMI"
    
    static let baseUrl = "http://127.0.0.1:3000"
    static var firstController: UIViewController {

//        return UINavigationController(rootViewController: meLoginController())
        
        let controller = didLogin == true ? meHomeManager() : UINavigationController(rootViewController: meLoginController())
        return controller
    }
    
}
