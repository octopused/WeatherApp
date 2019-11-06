//
//  City.swift
//  WeatherApp
//
//  Created by RuslanKa on 01.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import CoreData
import Foundation

struct City: Decodable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coordinates = "coord"
        case latitude = "lat"
        case longitude = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let coordinates = try container.decode([String: Double].self, forKey: .coordinates)
        latitude = coordinates[CodingKeys.latitude.rawValue]!
        longitude = coordinates[CodingKeys.longitude.rawValue]!
    }
    
    init(id: Int, name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(cityEntity: CityEntity) {
        self.id = Int(cityEntity.id)
        self.name = cityEntity.name
        self.latitude = cityEntity.latitude
        self.longitude = cityEntity.longitude
    }
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}

extension City {
    func createEntity(in queue: CoreDataManager.Queue) -> CityEntity? {
        let cityEntityDescription = CoreDataManager.shared.entityDescription(forName: CityEntity.entityName)
        let cityEntity = CityEntity(entity: cityEntityDescription, insertInto: CoreDataManager.shared.context(for: queue))
        cityEntity.id = Int32(self.id)
        cityEntity.name = self.name
        cityEntity.latitude = self.latitude
        cityEntity.longitude = self.longitude
        return cityEntity
    }
}
