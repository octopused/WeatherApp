//
//  CitiesListProtocols.swift
//  WeatherApp
//
//  Created by RuslanKa on 01.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation

typealias CityWeatherInfo = (City, Double?)

protocol CitiesListViewInput: class {
    func set(cities: [City])
    func set(weatherInfoList: [WeatherInfo])
    func enableAddCityButton(_ isEnabled: Bool)
    func reloadView()
}

protocol CitiesListViewOutput {
    func viewDidLoad()
    func showCitySearch()
    func reloadData()
}

protocol CitiesListAdapterOutput {
    func selectCity(_ city: City)
    func deleteCity(_ city: City)
}

protocol CitiesListModuleInput {
    
}

protocol CitiesListModuleOutput {
    
}

protocol CitiesListRouterInput {
    func showCityDetailInfo(city: City, weatherInfoList: [WeatherInfo])
    func showCitySearch(citySearchModuleOutput: CitySearchModuleOutput?)
}
