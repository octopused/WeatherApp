//
//  CityEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by RuslanKa on 04.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//
//

import Foundation
import CoreData

public class CityEntity: NSManagedObject {

}

extension CityEntity {

    @nonobjc public class func request() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String
    @NSManaged public var weatherInfo: NSSet?

}

// MARK: Generated accessors for weatherInfo
extension CityEntity {

    @objc(addWeatherInfoObject:)
    @NSManaged public func addToWeatherInfo(_ value: WeatherInfoEntity)

    @objc(removeWeatherInfoObject:)
    @NSManaged public func removeFromWeatherInfo(_ value: WeatherInfoEntity)

    @objc(addWeatherInfo:)
    @NSManaged public func addToWeatherInfo(_ values: NSSet)

    @objc(removeWeatherInfo:)
    @NSManaged public func removeFromWeatherInfo(_ values: NSSet)

}

extension CityEntity {
    
    static var entityName: String = "CityEntity"

}
