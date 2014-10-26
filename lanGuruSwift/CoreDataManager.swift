//
//  CoreDataManager.swift
//  lanGuru2.0
//
//  Created by Felix Belau on 20.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let storeFilename = "lanGuruSwift.sqlite"
    let dataModelResourceName = "lanGuruSwift"
    
    var objectStore: RKManagedObjectStore
    var managedObjectModel : NSManagedObjectModel
    
    init() {
        var modelURL: NSURL = NSBundle.mainBundle().URLForResource(dataModelResourceName, withExtension: "momd")!
        self.managedObjectModel = NSManagedObjectModel(contentsOfURL:modelURL)!
        self.objectStore = RKManagedObjectStore(managedObjectModel: self.managedObjectModel)
        var path: NSString = RKApplicationDataDirectory().stringByAppendingPathComponent(storeFilename);
        println(path);
        self.objectStore.addSQLitePersistentStoreAtPath(path, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options:optionsForSqliteStore, error: nil)
        self.objectStore.createManagedObjectContexts()
    }
    
    // Create a singleton Instance of CoreDataStorageManager
    
    class var sharedInstance : CoreDataManager {
    struct Static {
        static let instance : CoreDataManager = CoreDataManager()
        }
        return Static.instance
    }
    
    // #pragma mark - Core Data stack
    
    var managedObjectContext : NSManagedObjectContext {
        return self.objectStore.mainQueueManagedObjectContext;
    }
    
    var persistentManagedObjectContext : NSManagedObjectContext {
        return self.objectStore.persistentStoreManagedObjectContext;
    }
    
    var optionsForSqliteStore: Dictionary<NSString, Bool> = [
        NSInferMappingModelAutomaticallyOption: true,
        NSMigratePersistentStoresAutomaticallyOption: true
    ]
    
    func saveContext () {
        self.managedObjectContext.performBlock({
            if self.managedObjectContext.save(nil) {
                self.persistentManagedObjectContext.performBlock({
                    if self.persistentManagedObjectContext.save(nil) {
                        println("Saving success");
                    } else {
                        println("Saving failed");
                    }
                })
            } else {
                println("Saving main context failed");
            }
        })
    }
}