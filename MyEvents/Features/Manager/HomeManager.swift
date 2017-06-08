//
//  HomeManager.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

class meHomeManager: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let events = UINavigationController(rootViewController: meEventListController())
        events.tabBarItem.title = "Events"
        events.tabBarItem.image = #imageLiteral(resourceName: "calendar")
        
        let profile = UINavigationController(rootViewController: meProfileManager())
        profile.tabBarItem.title = "Profile"
        profile.tabBarItem.image = #imageLiteral(resourceName: "profile")
        
        viewControllers = [ events, profile]
    }
}
