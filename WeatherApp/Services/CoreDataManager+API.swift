//
//  CoreDataManager+API.swift
//  WeatherApp
//
//  Created by RuslanKa on 06.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func allEntities<T: NSManagedObject>(type: T.Type, entityName: String, queue: CoreDataManager.Queue = .main) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        guard let entities = try? context(for: queue).fetch(fetchRequest) else {
            return []
        }
        return entities
    }
    
    func entity<T: NSManagedObject>(type: T.Type, entityName: String, by predicate: NSPredicate, queue: CoreDataManager.Queue) -> T? {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        guard let entity = try? context(for: queue).fetch(fetchRequest).first else {
            return nil
        }
        return entity
    }
    
    func entities<T: NSManagedObject>(type: T.Type, entityName: String, by predicate: NSPredicate, queue: CoreDataManager.Queue) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        guard let entities = try? context(for: queue).fetch(fetchRequest) else {
            return []
        }
        return entities
    }
    
    func deleteEntity<T: NSManagedObject>(type: T.Type, entityName: String, by predicate: NSPredicate, queue: CoreDataManager.Queue) {
        guard let entity = entity(type: type, entityName: entityName, by: predicate, queue: queue) else {
            return
        }
        context(for: queue).delete(entity)
    }
    
    func deleteEntities<T: NSManagedObject>(type: T.Type, entityName: String, by predicate: NSPredicate, queue: CoreDataManager.Queue) {
        entities(type: type, entityName: entityName, by: predicate, queue: queue)
            .forEach { context(for: queue).delete($0) }
    }
    
    /// Update weather info in DB by WeatherInfo models and save DB
    func synchronize(weatherInfoList: [WeatherInfo], in queue: CoreDataManager.Queue) {
            for weatherInfo in weatherInfoList {
                let searchPredicate = NSPredicate(format: "city.id == %d AND date == %@",
                                                  weatherInfo.city.id, NSDate(timeInterval: 0, since: weatherInfo.date))
                if let entity = CoreDataManager.shared.entity(type: WeatherInfoEntity.self,
                                       entityName: WeatherInfoEntity.entityName,
                                       by: searchPredicate,
                                       queue: queue) {
                    entity.update(by: weatherInfo)
                } else {
                    _ = weatherInfo.createEntity(in: queue)
                }
            }
            CoreDataManager.shared.save(in: queue)
    }
    
    // Update cities in DB by City models and save DB
    func synchronize(cities: [City], in queue: CoreDataManager.Queue) {
        DispatchQueue.global(qos: .userInitiated).async {
            for city in cities {
                let predicate = NSPredicate(format: "id == %d", city.id)
                if CoreDataManager.shared.entity(type: CityEntity.self,
                                                 entityName: CityEntity.entityName,
                                                 by: predicate,
                                                 queue: queue) == nil {
                    _ = city.createEntity(in: queue)
                    CoreDataManager.shared.save(in: queue)
                }
            }
        }
    }
    
}
