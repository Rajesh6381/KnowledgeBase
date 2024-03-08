//
//  CoreDataManager.swift
//  KBDashBoard
//
//  Created by Rajesh R on 19/02/24.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager<T: NSManagedObject>: NSObject{
    
    
    // create a context for managing object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchResultController: NSFetchedResultsController<T>!
    
    let request: NSFetchRequest<T>
    
    lazy var persistentContainer: NSManagedObjectContext = {
       let container =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
        container.automaticallyMergesChangesFromParent = true
     return container
     }()
    
    
    
    init(entity: String){
        print(context)
        request = NSFetchRequest<T>(entityName: entity)
        
    }
    
    func loadSavedData() {
        do{
            try fetchResultController.performFetch()
            print("fetchresult fetched the data")
            print(fetchResultController.fetchedObjects)
            
        }catch let error{
            print(error)
        }
    }
    

    

    
    
    func fetchData() -> [T]?{
        do{
            let data = try self.context.fetch(request)
            print("Core Data Fetched successfully")
            print(data)
            return data
        }catch let error{
            print(error)
        }
        
        return nil
    }
    
    
    func saveData(){
        do {
            //try persistentContainer.save()
            try context.save()
            print("saved")
            // Merge changes into the main context
//            NotificationCenter.default.addObserver(forName: .NSManagedObjectContextDidSave, object: context, queue: .current) { notification in
//                print("notifications centre")
//                self.context.mergeChanges(fromContextDidSave: notification)
//            }
        }catch let error{
            print("unable to save the data")
            print(error)
        }
    }
    
    func deleteAllData(forEntityName entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            let persistentStoreCoordinator = context.persistentStoreCoordinator
            try persistentStoreCoordinator?.execute(batchDeleteRequest, with: context)
            
            // Save changes
            saveData()
            print("deleted")
        } catch {
            print("Error deleting data for entity \(entityName): \(error)")
        }
    }
    
    
}
