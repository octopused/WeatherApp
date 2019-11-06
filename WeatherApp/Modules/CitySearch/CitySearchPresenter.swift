//
//  CitySearchPresenter.swift
//  WeatherApp
//
//  Created by RuslanKa on 03.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation

final class CitySearchPresenter {
    weak var view: CitySearchViewInput?
    var router: CitySearchRouterInput?
    var output: CitySearchModuleOutput?
    
    var weatherService = OpenWeatherAPIService()
    var locationManager = LocationManager()
}

// MARK: - CitySearchViewOutput

extension CitySearchPresenter: CitySearchViewOutput {
    func viewDidLoad() {
        
    }
    
    func close() {
        router?.close()
    }
    
    func searchCity(with text: String) {
        locationManager.getPlaces(forPlaceCalled: text) { [weak self] (placemarks) in
            for placemark in placemarks {
                guard let latitude = placemark.location?.coordinate.latitude,
                    let longitude = placemark.location?.coordinate.longitude else {
                        continue
                }
                self?.weatherService.getWeatherCurrent(latitude: latitude, longitude: longitude) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let response):
                        let city = WeatherInfo(weatherResponse: response).city
                        DispatchQueue.main.async { [weak self] in
                            self?.view?.setSearchResults([city])
                        }
                    }
                }
            }
            
        }
    }
}

// MARK: - CitySearchTableAdapterOutput

extension CitySearchPresenter: CitySearchTableAdapterOutput {
    func addCity(_ city: City) {
        output?.addCity(city)
        router?.close()
    }
}

