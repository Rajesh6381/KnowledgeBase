//
//  KBSubCategoryBinder.swift
//  KBDashBoard
//
//  Created by Rajesh R on 28/02/24.
//

import Foundation
import ZohoDeskPlatformDataBridge
import CoreData

class KBSubCategoryBinder: KBbinder{
    
    var articles: NSFetchedResultsController<CoreDataKBArticleModal>?
    var categoryId: String?
    
    
    
    init(id: String){
        super.init(identifier: .KBArticleScreen)
        self.categoryId = id
    }
    
    override func initialize(onCompletion: @escaping ((ZohoDeskPlatformDataBridge.ZPIntializeProgress) -> Void)) {
        super.initialize(onCompletion: onCompletion)
        loadingIndicator?(.begin)
        if let id = categoryId{
            let builder = Builder()
            builder.build(instance: self, categoriesPath: KBCategoryPath.KBArticles(id: id))
        }
    }
    
    
    override func numberOfRows(_ section: Int) -> Int {
        return articles?.fetchedObjects?.count ?? 0
    }
    
    override func render(basedOn patternType: ZDPatternType) -> String? {
        
        switch patternType{
            case .list(_):
                return KBStrings.PatternIdentifier.ArticleCell.rawValue
            default:
                return super.render(basedOn: patternType)
        }
    }
    
    override func prepareData(of dataSourceType: ZohoDeskPlatformDataBridge.ZBDataSourceType) -> [ZohoDeskPlatformDataBridge.ZBDataItem] {
        
        switch dataSourceType{
            case .list(.getElement(let index, let elements)):
                guard let cdData = self.articles else{
                    return []
                }
                let object = cdData.object(at: index)
        
                elements.forEach({data in
                    
                    switch KBStrings.ArticleCellKeys(rawValue: data.key){
                        case .Image:
                            data.imageValue.image = UIImage(systemName: "doc.text")
                        case.Title:
                            data.value.plainString = object.title
                        default:
                            print("no keys in list")
                    }
                })
                return elements
            default:
                return super.prepareData(of: dataSourceType)
        }
    }
}

extension KBSubCategoryBinder: SetProtocol{
    func setData<T>(categoriesModal: NSFetchedResultsController<T>?) where T : NSManagedObject {

        self.articles =  categoriesModal as? NSFetchedResultsController<CoreDataKBArticleModal>
        handler?(.refresh)
        loadingIndicator?(.end)
    }
    
    func notify(update: TableUpdate) {
        switch update{
            case .inserting(let indexPath, let newIndexPath):
                guard let data = self.articles?.object(at: indexPath) else{
                    return
                }
                dbNotifier?(.list(data, newIndexPath , .insert, indexPath))
            case .deleting(indexPath: let indexPath, newIndexPath: let newIndexPath):
                guard let data = self.articles?.object(at: indexPath) else{
                    return
                }
                dbNotifier?(.list(data, indexPath, .delete, newIndexPath))
            case .updating(indexPath: let indexPath, newIndexPath: let newIndexPath):
                guard let data = self.articles?.object(at: indexPath) else{
                    return
                }
                dbNotifier?(.list(data, indexPath, .update, newIndexPath))
            default:
                print("move")
        }
    }
    
    
}
