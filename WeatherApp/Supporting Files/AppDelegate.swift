//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by RuslanKa on 28.10.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let citiesListViewController = CitiesListModuleConfigurator().createModule(with: [])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: citiesListViewController)
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        try? CoreDataManager.shared.mainContext.save()
    }
}

