//
//  Setting.swift
//  Marco
//
//  Created by Ky Nguyen on 6/5/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

struct meSetting {
    
    static let placeApiKey = "AIzaSyAh9IFVETKbu3srSyWFtNHl2PgToJqrKMI"
    
    static let baseUrl = ""
    static var firstController: UIViewController {
        
        let testingTime = true
        
        if testingTime == true {
            return UINavigationController(rootViewController: meProfileManager())
        }
        else {
            return UIViewController()
        }
    }
    
}
