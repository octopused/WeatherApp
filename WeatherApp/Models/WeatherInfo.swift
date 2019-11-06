//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by RuslanKa on 01.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import CoreData
import Foundation

public struct WeatherInfo {
    var city: City
    var temperature: Double
    var temperatureMin: Double
    var temperatureMax: Double
    var windSpeed: Double
    var humidity: Double
    var date: Date
    var isCurrentWeather: Bool
 
    init(city: City, temperature: Double, temperatureMin: Double, temperatureMax: Double, humidity: Double, windSpeed: Double, date: Date, isCurrentWeather: Bool) {
        self.city = city
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.date = date
        self.isCurrentWeather = isCurrentWeather
    }
    
    init(weatherResponse: WeatherResponse) {
        let latitude = weatherResponse.coordinates.latitude
        let longitude = weatherResponse.coordinates.longitude
        self.city = City(id: weatherResponse.cityId, name: weatherResponse.cityName, latitude: latitude, longitude: longitude)
        self.temperature = weatherResponse.mainWeatherInfo.temperature
        self.temperatureMin = weatherResponse.mainWeatherInfo.temperatureMin
        self.temperatureMax = weatherResponse.mainWeatherInfo.temperatureMax
        self.humidity = weatherResponse.mainWeatherInfo.humidity
        self.windSpeed = weatherResponse.windInfo.windSpeed
        self.date = weatherResponse.date
        self.isCurrentWeather = true
    }
    
    init(entity: WeatherInfoEntity) {
        self.city = City(cityEntity: entity.city!)
        self.temperature = entity.temperature
        self.temperatureMin = entity.temperatureMin
        self.temperatureMax = entity.temperatureMax
        self.humidity = entity.humidity
        self.windSpeed = entity.windSpeed
        self.date = entity.date
        self.isCurrentWeather = entity.isCurrentWeather
    }
    
    static func initFrom(forecastResponse: ForecastResponse) -> [WeatherInfo] {
        let latitude = forecastResponse.city.coordinates.latitude
        let longitude = forecastResponse.city.coordinates.longitude
        let city = City(id: forecastResponse.city.id, name: forecastResponse.city.name, latitude: latitude, longitude: longitude)
        let weatherInfoList = forecastResponse.list
            .map { WeatherInfo(city: city,
                               temperature: $0.mainInfo.temperature,
                               temperatureMin: $0.mainInfo.temperatureMin,
                               temperatureMax: $0.mainInfo.temperatureMax,
                               humidity: $0.mainInfo.humidity,
                               windSpeed: $0.windInfo.windSpeed,
                               date: $0.date,
                               isCurrentWeather: false)
            }
        return weatherInfoList
    }
}

extension WeatherInfo {
    
    func createEntity(in queue: CoreDataManager.Queue) -> WeatherInfoEntity? {
        let entityDescription = CoreDataManager.shared.entityDescription(forName: WeatherInfoEntity.entityName)
        let entity = WeatherInfoEntity(entity: entityDescription, insertInto: CoreDataManager.shared.context(for: queue))
        
        guard let cityEntity = CoreDataManager.shared.entity(type: CityEntity.self,
                                                       entityName: CityEntity.entityName,
                                                       by: NSPredicate(format: "id == %d", self.city.id),
                                                       queue: queue) ??
            self.city.createEntity(in: queue) else {
            return nil
        }
        
        entity.city = cityEntity
        entity.temperature = self.temperature
        entity.temperatureMin = self.temperatureMin
        entity.temperatureMax = self.temperatureMax
        entity.humidity = self.humidity
        entity.windSpeed = self.windSpeed
        entity.date = self.date
        entity.isCurrentWeather = self.isCurrentWeather
        
        return entity
    }
}
