//
//  FirstLaunch.swift
//  WeatherApp
//
//  Created by RuslanKa on 07.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation

final class FirstLaunch {
    
    let userDefaults: UserDefaults = .standard
    
    let wasLaunchedBefore: Bool
    
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore
    }
    
    init() {
        let key = "WeatherApp.FirstLaunch.WasLaunchedBefore"
        let wasLaunchedBefore = userDefaults.bool(forKey: key)
        self.wasLaunchedBefore = wasLaunchedBefore
        if !wasLaunchedBefore {
            userDefaults.set(true, forKey: key)
        }
    }
    
}
