//
//  CoreDataService.swift
//  WeatherApp
//
//  Created by RuslanKa on 04.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    
    enum Queue {
        case main
        case background
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    var mainContext: NSManagedObjectContext
    var backgroundContext: NSManagedObjectContext
    
    private init() {
        backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.automaticallyMergesChangesFromParent = true
        mainContext = persistentContainer.viewContext
    }
    
    func save(in queue: CoreDataManager.Queue) {
        switch queue {
        case .main:
            if mainContext.hasChanges {
                do {
                    try mainContext.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        case .background:
            backgroundContext.performAndWait {
                do {
                    try backgroundContext.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    func context(for queue: CoreDataManager.Queue) -> NSManagedObjectContext {
        switch queue {
        case .main:
            return mainContext
        case .background:
            return backgroundContext
        }
    }
    
    func entityDescription(forName entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: persistentContainer.viewContext)!
    }
    
}
