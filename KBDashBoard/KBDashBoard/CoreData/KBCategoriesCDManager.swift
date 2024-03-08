//
//  KBCategoriesDataManage.swift
//  KBDashBoard
//
//  Created by Rajesh R on 20/02/24.
//

import Foundation
import CoreData
import SwiftUI
import UIKit
import SwiftProtobuf


protocol CDManager{
    func syncData<T: Codable>(modal: [T], from path: KBCategoryPath)
    func getData<T: NSManagedObject>(from categories: KBCategoryPath) -> NSFetchedResultsController<T>?
}


class KBCategoriesCDManager:CoreDataManager<CoreDataKBCategoriesModal>,CDManager{
    
    
   
    weak var interactor: Notify?

    init() {
        super.init(entity: "CoreDataKBCategoriesModal")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        
        fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
    }
  
    
    func createCategoryEntity(category: KBCategoriesModal) {
        print("creating")
        let coreDataModal = CoreDataKBCategoriesModal(context: context)
        
        coreDataModal.description = category.description ?? ""
        coreDataModal.isFollowing = category.isFollowing
        coreDataModal.articlesCount = category.articlesCount
        coreDataModal.id = category.id
        coreDataModal.level = category.level
        coreDataModal.locale = category.locale
        coreDataModal.logoUrl = category.logoUrl
        coreDataModal.name = category.name
        coreDataModal.parentCategoryId = category.parentCategoryId
        coreDataModal.permalink =  category.permalink
        coreDataModal.primaryDepartmentIds = category.primaryDepartmentId
        coreDataModal.rootCategoryId = category.rootCategoryId ?? ""
        coreDataModal.sectionsCount = category.sectionsCount
        coreDataModal.translatedName = category.translatedName
        coreDataModal.transalatedDescription = category.translatedDescription
        coreDataModal.visibility = category.visibility
        coreDataModal.webUrl = category.webUrl
    }
    
    func saveCategoryInCoreData(data: [KBCategoriesModal]){
        deleteAllData(forEntityName: "CoreDataKBCategoriesModal")
        let _ =  data.map({ categoryData in
            createCategoryEntity(category: categoryData)
        })
        
        saveData()
    }
    
    func getData<T: NSManagedObject>(from categories: KBCategoryPath) -> NSFetchedResultsController<T>?{
        
        switch categories{
            case .KBRootCategories:
                let predicate = NSPredicate(format: "rootCategoryId == %@","")
                request.predicate = predicate
                loadSavedData()
            case .KBSubCategories(let id):
                let predicate = NSPredicate(format: "parentCategoryId == %@", id)
                request.predicate = predicate
                loadSavedData()
            default:
                print("default cases")
        }
        //fetchResultController.delegate = self
        return fetchResultController as? NSFetchedResultsController<T>
    }
    


    // sync data to core data
    func syncData<T>(modal: [T], from path: KBCategoryPath){
        print("syncing")
        guard let data = modal as? [KBCategoriesModal] else{
            return
        }
        
        var ids:[String] = categories(modal: data , from: path)
        
        deleteData(with: ids)
        saveData()
    }
    
    func categories(modal: [KBCategoriesModal], from path: KBCategoryPath) -> [String]{
        
        let data = modal.map({ category in
            selectCategories(data: category,with: path)
            return category.id
        })
        
        return data
    }
    
    func selectCategories(data category: KBCategoriesModal,with path: KBCategoryPath){
        switch path{
            case .KBRootCategories:
                addCategoriesData(data: category)
                //for delete to set predicate
                let predicate = NSPredicate(format: "rootCategoryId == %@", "")
                request.predicate = predicate
            case .KBSubCategories(let id):
                addSubCategoriesData(data: category)
                let predicate = NSPredicate(format: "rootCategoryId == %@", id)
                request.predicate = predicate
            default:
                print("default case")
        }
    }
    
    //compare and delete the core data which is not in api
    func deleteData(with ids: [String]){
        
        do{
           let _ = try persistentContainer.fetch(request).map({data in
                if !ids.contains(data.id){
                    context.delete(data)
                }
            })
        }catch{
            print("error while deleting")
        }
    }

    
    func addCategoriesData(data: KBCategoriesModal){
        let predicate = NSPredicate(format: "id == %@", data.id)
        request.predicate = predicate
        fetchingData(kbModal: data)
    }
    
    
    func addSubCategoriesData(data: KBCategoriesModal){
        let predicate = NSPredicate(format: "id == %@", data.id)
        request.predicate = predicate
        fetchingData(kbModal: data)
    }
    
    // fetching data from core data for merging operations
    func fetchingData(kbModal: KBCategoriesModal){
        do{
            let coreData = try persistentContainer.fetch(request)
            mergeOrCreate(coreData: coreData, data: kbModal)
        }catch let error{
            print(error)
        }
    }
    

    // merge or create new data
    func mergeOrCreate(coreData: [CoreDataKBCategoriesModal],data: KBCategoriesModal){
        
        if(!coreData.isEmpty){
            let category = coreData.first
            print("overrite")
            category?.description = data.description ?? ""
            category?.isFollowing = data.isFollowing
            category?.articlesCount = data.articlesCount
            category?.level = data.level
            category?.name = data.name
            category?.parentCategoryId = data.parentCategoryId
            category?.sectionsCount = data.sectionsCount
            category?.translatedName = data.translatedName
            category?.transalatedDescription = data.translatedDescription
            category?.visibility = data.visibility
        }else{
            createCategoryEntity(category: data)
        }
    }
}

extension KBCategoriesCDManager: NSFetchedResultsControllerDelegate{
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
            case .insert:
                print("insert")
                interactor?.notifications(table: .inserting(indexPath: newIndexPath!, newIndexPath: IndexPath()))
            case .delete:
                print("delete")
                interactor?.notifications(table: .deleting(indexPath: indexPath!, newIndexPath: IndexPath()))
            case .update:
                print("update")
                interactor?.notifications(table: .updating(indexPath: indexPath!, newIndexPath: IndexPath()))
            case .move:
                print("move")
            
            default:
            print("deault cases")
        }
    }
    
}


enum TableUpdate{
    case inserting(indexPath: IndexPath,newIndexPath: IndexPath)
    case deleting(indexPath: IndexPath,newIndexPath: IndexPath)
    case updating(indexPath: IndexPath,newIndexPath: IndexPath)
    case moving(indexPath: IndexPath,newIndexPath: IndexPath)
}
