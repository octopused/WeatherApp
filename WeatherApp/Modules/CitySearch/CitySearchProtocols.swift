//
//  CitySearchProtocols.swift
//  WeatherApp
//
//  Created by RuslanKa on 03.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation

protocol CitySearchViewInput: class {
    func setSearchResults(_ cities: [City])
}

protocol CitySearchViewOutput {
    func viewDidLoad()
    func close()
    func searchCity(with text: String)
}

protocol CitySearchModuleOutput {
    func addCity(_ city: City)
}

protocol CitySearchRouterInput {
    func close()
}

protocol CitySearchTableAdapterOutput {
    func addCity(_ city: City)
}
