//
//  CoreDataStack.swift
//  MyMovies
//
//  Created by Casualty on 10/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let movie: String = "Movie"
    
    lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: movie)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent data \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error { throw error }
    }
}
