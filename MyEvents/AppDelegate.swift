//
//  AppDelegate.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/6/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupApp()
        return true
    }
    
    func setupGooglePlace() {
        GMSPlacesClient.provideAPIKey(marSetting.placeApiKey)
        GMSServices.provideAPIKey(marSetting.placeApiKey)
    }
    
    func setupApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = meSetting.firstController
        window!.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
    }

}

