//
//  KBArticleCDManager.swift
//  KBDashBoard
//
//  Created by Rajesh R on 20/02/24.
//

import Foundation
import CoreData

class KBArticleCDManager: CoreDataManager<CoreDataKBArticleModal>, CDManager {
  
    
    
    weak var interactor: Notify?
    
    init() {
        super.init(entity: "CoreDataKBArticleModal")
        
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
    }
    
    func createArticleEntity(articleData: KBArticlesModal){
        print("Creating")
        let articleCDModal = CoreDataKBArticleModal(context: context)
        
        articleCDModal.title =  articleData.title
        articleCDModal.locale =  articleData.locale
        articleCDModal.id = articleData.id
        articleCDModal.summary =  articleData.summary
        articleCDModal.permalink =  articleData.permalink
        articleCDModal.modifiedTime = articleData.modifiedTime
        articleCDModal.webUrl = articleData.webUrl
        articleCDModal.createdTime = articleData.createdTime
        articleCDModal.translationId = articleData.translationId
        articleCDModal.rootcategoryId = articleData.rootCategoryId
        articleCDModal.categoryId = articleData.categoryId
        articleCDModal.likeCount = articleData.likeCount
        articleCDModal.dislikeCount = articleData.dislikeCount
        articleCDModal.answer = articleData.answer
        
    }
    
    func getData<T: NSManagedObject>(from categories: KBCategoryPath) -> NSFetchedResultsController<T>?{
        
        switch categories{
            case .KBArticles(let id):
                let predicate = NSPredicate(format: "categoryId == %@", id)
                request.predicate = predicate
                loadSavedData()
            case .KBArticleDetails(let id):
                let predicate = NSPredicate(format: "id == %@", id)
                request.predicate  =  predicate
                loadSavedData()
            default:
                print("default")
        }
        //fetchResultController.delegate = self
        return fetchResultController as? NSFetchedResultsController<T>
    }
    
    func articlePredicate(id: String){
        let predicate = NSPredicate(format: "id == %@",id)
        request.predicate = predicate
    }
    

    
    func deleteArticle(articles: [KBArticlesModal]){
        
        let ids = articles.map({data in
            return data.id
        })
        
        do{
            let _ = try persistentContainer.fetch(request).map({data in
                if !ids.contains(data.id){
                    context.delete(data)
                    print("deleted")
                }
            })
        }catch let error{
            print("error while deleting")
            print(error)
        }
    }
    func syncData<T>(modal: [T],from path: KBCategoryPath){
        print("syncing")
        
        let _ = modal.map({ article in
            addArticlesData(data: article as! KBArticlesModal,for: path)
        })
        
        deleteArticle(articles: modal as! [KBArticlesModal])
        saveData()
    }
    
    func addArticlesData(data: KBArticlesModal,for path : KBCategoryPath){
        
        switch path{
            case .KBArticles(let id):
                let predicate = NSPredicate(format: "id == %@",data.id)
                request.predicate = predicate
                fetchingData(modal: data)
                //for delete set predicate
                let predicates = NSPredicate(format: "categoryId == %@",id)
                request.predicate = predicates
            case .KBArticleDetails(_):
                let predicate = NSPredicate(format: "id == %@",data.id)
                request.predicate = predicate
                fetchingData(modal: data)
            default:
                print("default")
        }
    }
    
    
    
    func fetchingData(modal data: KBArticlesModal){
        do{
            let coreData = try context.fetch(request)
            mergingData(coreData: coreData, data: data)
            
        }catch let error{
            print("error while fetching by id")
            print(error)
        }
    }
    
    
    func mergingData(coreData: [CoreDataKBArticleModal],data: KBArticlesModal){
        if(!coreData.isEmpty){
            print("overrriding elements")
            let article = coreData.first
            article?.title = data.title
            article?.modifiedTime = data.modifiedTime
            article?.summary = data.summary
            article?.answer = data.answer.isNil ? article?.answer : data.answer
            article?.likeCount = data.likeCount.isNil ? article?.likeCount : data.likeCount
            article?.dislikeCount = data.dislikeCount.isNil ? article?.dislikeCount : data.dislikeCount
        }else{
            createArticleEntity(articleData: data)
        }
    }
    

    
    func saveArticleInCoreData(data: [KBArticlesModal]){
        let _ = data.map({article in
            createArticleEntity(articleData: article)
        })
        saveData()
    }
    
    
}

extension KBArticleCDManager: NSFetchedResultsControllerDelegate{
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("controller")
        switch type{
            case .insert:
                print("insert")
                interactor?.notifications(table: .inserting(indexPath: newIndexPath!, newIndexPath: IndexPath()))
            case .delete:
                print("delete")
                interactor?.notifications(table: .deleting(indexPath: indexPath!, newIndexPath: IndexPath()))
            case .update:
                print("update")
                interactor?.notifications(table:.updating(indexPath: indexPath!, newIndexPath: IndexPath()))
            case .move:
                print("move")
            default:
                print("default case")
        }
    }
    
}
