//
//  AppDelegate.swift
//  Dotabase
//
//  Created by zhussupov on 25.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        let vc = ViewController()
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }



}

