//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by RuslanKa on 05.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation
import Reachability

protocol NetworkManagerDelegate: class {
    func internetConnectionStatusChanged(_ state: Reachability.Connection)
}

final class NetworkManager: NSObject {
    
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    weak var delegate: NetworkManagerDelegate?
    
    var reachability = try! Reachability()
    
    var connectionStatus: Reachability.Connection {
        return reachability.connection
    }
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(networkStatusChanged(_:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print(error)
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        delegate?.internetConnectionStatusChanged(connectionStatus)
    }
    
}
