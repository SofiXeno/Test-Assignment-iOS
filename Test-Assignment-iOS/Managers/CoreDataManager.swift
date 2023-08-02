//
//  CoreDataManager.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager <T: NSManagedObject> {

    // MARK: - Properties
    lazy var persistentContainer: NSPersistentContainer = {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
        
    }()
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
  
        if self.context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - fetch data
    func fetch(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
     
            return fetchedObjects ?? [T]()
        } catch {
            fatalError("Failed to fetch \(entityName): \(error)")
        }
    }
    
    // MARK: - delete object
    func delete(_ object: NSManagedObject) {
        self.context.delete(object)
        self.saveContext()
    }
    
    
    // MARK: - delete by some predicate
    func deleteByPredicate(fetchRequest : NSFetchRequest<T>){
    
        do {
            let results = try self.context.fetch(fetchRequest)
            for result in results {
                self.delete(result)
            }
            
        } catch {
            print("Error deleting object: \(error)")
        }

    }
    
    // MARK: - clear all data
    func clearAllData(){
        let entityNames = self.persistentContainer.managedObjectModel.entities.compactMap { $0.name }
            for entityName in entityNames {
            
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                do {
                    try self.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: self.context)
                } catch let error as NSError {
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
}



