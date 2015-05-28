//
//  CoreDataStack.swift
//  SimpleMap
//
//  Created by Nathaniel Jones on 5/26/15.
//  Copyright (c) 2015 Nate Geo LLC. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    let context : NSManagedObjectContext
    let psc : NSPersistentStoreCoordinator
    let model : NSManagedObjectModel
    let store : NSPersistentStore?
    
    class func applicationDocumentDirectory() ->NSURL {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as! [NSURL]
        return urls[0]
    }
    
    init() {
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Simple Map", withExtension: "momd")
        model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        
        psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        context = NSManagedObjectContext()
        
        context.persistentStoreCoordinator = psc;
        
        let documentsURL = CoreDataStack.applicationDocumentDirectory()
        
        let storeURL = documentsURL.URLByAppendingPathComponent("Simple Map")
        
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        var error : NSError? = nil
        store = psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options, error: &error)
        
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }
    func saveContext() {
        var error : NSError? = nil
        if context.hasChanges && !context.save(&error) {
            println("Could not save: \(error), \(error?.userInfo)")
        }
    }
}