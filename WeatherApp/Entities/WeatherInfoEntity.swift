//
//  WeatherInfoEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by RuslanKa on 04.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//
//

import Foundation
import CoreData


public class WeatherInfoEntity: NSManagedObject {

}

extension WeatherInfoEntity {

    @nonobjc public class func request() -> NSFetchRequest<WeatherInfoEntity> {
        return NSFetchRequest<WeatherInfoEntity>(entityName: "WeatherInfoEntity")
    }

    @NSManaged public var date: Date
    @NSManaged public var humidity: Double
    @NSManaged public var temperature: Double
    @NSManaged public var temperatureMax: Double
    @NSManaged public var temperatureMin: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var isCurrentWeather: Bool
    @NSManaged public var city: CityEntity?

}

extension WeatherInfoEntity {
    
    static var entityName: String = "WeatherInfoEntity"
    
    func update(by weatherInfo: WeatherInfo) {
        self.temperature = weatherInfo.temperature
        self.temperatureMin = weatherInfo.temperatureMin
        self.temperatureMax = weatherInfo.temperatureMax
        self.humidity = weatherInfo.humidity
        self.windSpeed = weatherInfo.windSpeed
    }
}
