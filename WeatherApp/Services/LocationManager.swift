//
//  LocationManager.swift
//  WeatherApp
//
//  Created by RuslanKa on 03.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import CoreLocation
import Foundation

class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func getPlaces(forPlaceCalled name: String, completion: @escaping ([CLPlacemark]) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
            } else {
                completion(placemarks ?? [])
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
}
