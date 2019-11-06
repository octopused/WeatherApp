//
//  CitiesListPresenter.swift
//  WeatherApp
//
//  Created by RuslanKa on 01.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation
import Reachability

class CitiesListPresenter {
    weak var view: CitiesListViewInput?
    var router: CitiesListRouterInput?
    var weatherService = OpenWeatherAPIService()
    
    var cities: [City] = []
    var weatherInfoList: [WeatherInfo] = []
    
    init(cities: [City]) {
        self.cities = cities
        NetworkManager.shared.delegate = self
    }
    
    // MARK: - Private Methods
    
    func preloadCities() -> [City] {
        guard let jsonUrl = Bundle.main.url(forResource: "InitData", withExtension: "json"),
            let data = try? Data(contentsOf: jsonUrl, options: .mappedIfSafe) else {
            return []
        }
        let cities = try? JSONDecoder().decode([City].self, from: data)
        return cities ?? []
    }
    
    func getCities() -> [City] {
        let cityEntites = CoreDataManager.shared.allEntities(type: CityEntity.self, entityName: CityEntity.entityName)
        return cityEntites.map { City(cityEntity: $0) }
    }
    
    func fetchWeatherInfo(for city: City) -> [WeatherInfo] {
        let predicate = NSPredicate(format: "city.id == %d", city.id)
        let weatherInfoEntityList = CoreDataManager.shared.entities(type: WeatherInfoEntity.self,
                                                              entityName: WeatherInfoEntity.entityName,
                                                              by: predicate,
                                                              queue: .background)
        return weatherInfoEntityList.map { WeatherInfo(entity: $0) }
    }
    
    func loadWeatherInfo(for city: City, completion: @escaping ([WeatherInfo]) -> Void) {
        if NetworkManager.shared.connectionStatus == .unavailable {
            completion(fetchWeatherInfo(for: city))
        } else {
            weatherService.getWeatherForecast(cityId: city.id) { [weak self] (result) in
                switch result {
                case .success(let forecastResponse):
                    let weatherInfoList = WeatherInfo.initFrom(forecastResponse: forecastResponse)
                    CoreDataManager.shared.synchronize(weatherInfoList: weatherInfoList, in: .background)
                    completion(weatherInfoList)
                case .failure(let error):
                    print(error)
                    completion(self?.fetchWeatherInfo(for: city) ?? [])
                }
            }
        }
    }
    
    func displayWeather(for city: City) {
        loadWeatherInfo(for: city) { [weak self] (weatherInfoList) in
            guard let self = self else {
                return
            }
            self.weatherInfoList.removeAll(where: { $0.city == city })
            self.weatherInfoList.append(contentsOf: weatherInfoList)
            self.view?.set(weatherInfoList: self.weatherInfoList)
            DispatchQueue.main.async { [weak self] in
                self?.view?.reloadView()
            }
        }
    }

}

// MARK: - CitiesListViewOutput

extension CitiesListPresenter: CitiesListViewOutput {
    func viewDidLoad() {
        cities = getCities()
        if cities.count == 0 && FirstLaunch().isFirstLaunch {
            cities = preloadCities()
        }
        view?.set(cities: cities)
        view?.reloadView()
        cities.forEach { displayWeather(for: $0) }
    }
    
    func showCitySearch() {
        router?.showCitySearch(citySearchModuleOutput: self)
    }
    
    func reloadData() {
        cities.forEach { displayWeather(for: $0) }
        CoreDataManager.shared.synchronize(cities: cities, in: .background)
    }
}

// MARK: - CitiesListAdapterOutput

extension CitiesListPresenter: CitiesListAdapterOutput {
    func selectCity(_ city: City) {
        let weatherInfoForCity = weatherInfoList.filter { $0.city == city }
        router?.showCityDetailInfo(city: city, weatherInfoList: weatherInfoForCity)
    }
    
    func deleteCity(_ city: City) {
        let predicate = NSPredicate(format: "id == %d", city.id)
        CoreDataManager.shared.deleteEntity(type: CityEntity.self, entityName: CityEntity.entityName, by: predicate, queue: .background)
        CoreDataManager.shared.save(in: .background)
        cities = getCities()
        view?.set(cities: cities)
        view?.reloadView()
    }
}

// MARK: - CitySearchModuleOutput

extension CitiesListPresenter: CitySearchModuleOutput {
    func addCity(_ city: City) {
        if !cities.contains(city) {
            CoreDataManager.shared.synchronize(cities: [city], in: .background)
            cities.append(city)
            view?.set(cities: cities)
            DispatchQueue.main.async { [weak self] in
                self?.view?.reloadView()
            }
            displayWeather(for: city)
        }
    }
}

// MARK: - NetworkManagerDelegate

extension CitiesListPresenter: NetworkManagerDelegate {
    func internetConnectionStatusChanged(_ state: Reachability.Connection) {
        view?.enableAddCityButton(state != .unavailable)
    }
}
