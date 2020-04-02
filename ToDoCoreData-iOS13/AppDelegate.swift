//
//  AppDelegate.swift
//  ToDoCoreData-iOS13
//
//  Created by Dennis Nesanoff on 29.03.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
    }

}

