//
//  KBCategoryBinder.swift
//  KBDashBoard
//
//  Created by Rajesh R on 26/02/24.
//

enum ScreenIdentifier: String{
    case KBCategoryScreen = "kbCategoryScreen"
    case KBArticleScreen = "kbSubCategoryListScreen"
}

import Foundation
//import ZohoDeskPlatformUIKit
import ZohoDeskPlatformDataBridge
import CoreData

class KBCategoryBinder: KBbinder {

    var categories: NSFetchedResultsController<CoreDataKBCategoriesModal>?
    var kbPath: KBCategoryPath?
    
    init(path: KBCategoryPath){
        super.init(identifier: ScreenIdentifier.KBCategoryScreen)
        self.kbPath = path
    }
    

    
    override func initialize(onCompletion: @escaping ((ZohoDeskPlatformDataBridge.ZPIntializeProgress) -> Void)) {
        super.initialize(onCompletion: onCompletion)
        loadingIndicator?(.begin)
        if let pathAvailable  =  self.kbPath, self.categories == nil{
            print("instance is calling")
            let builder = Builder()
            builder.build(instance: self,categoriesPath: pathAvailable)
        }
    }
    
    
    
    override func render(basedOn patternType: ZDPatternType) -> String? {
        switch patternType{
            case .list(_):
            return KBStrings.PatternIdentifier.CategoryCell.rawValue
            default:
                return super.render(basedOn: patternType)
        }
    }
    
    override func numberOfSections() -> Int {
        return categories?.fetchedObjects?.count ?? 0
    }
    
    override func numberOfRows(_ section: Int) -> Int {
        return 1
    }
    
    override func prepareData(of dataSourceType: ZBDataSourceType) -> [ZBDataItem] {
        switch dataSourceType {
        case .list(.getElement(let index, let elements)):
            guard let cdData = categories?.object(at: IndexPath(row: index.section, section: index.row)) else{
                return []
            }
            elements.forEach({ data in
                data.value.conditionalValue = "notClicked"
                switch KBStrings.CategoryCellKeys(rawValue: data.key){
                    case .Image:
                        if !cdData.logoUrl.isNil{
                            data.value.urlString = cdData.logoUrl
                        }else{
                            data.imageValue.image = UIImage(systemName: "photo")
                        }
                    case .Title:
                        data.value.plainString = cdData.name
                    case .Description:
                        if cdData.description == "" {
                            data.isHide = true
                        }else{
                            data.value.plainString = cdData.description
                        }
                    case .Articles:
                        if cdData.articlesCount == "0"{
                            data.isHide = true
                        }
                    case .ArticleTitle:
                        data.value.plainString = "Articles"
                    case .ArtilceCount:
                        data.value.plainString = cdData.articlesCount
                    case .Sections:
                        if  cdData.sectionsCount == "0"{
                            data.isHide = true
                        }
                    case .SectionTitle:
                        data.value.plainString = "Sections"
                    case .SectionCount:
                        data.value.plainString = cdData.sectionsCount
                    case .none:
                        print("category list is none")
                }})
                return elements
            default:
                return super.prepareData(of: dataSourceType)
        }
        
    }
    
    
    override func doPerform(builderAction action: ZPUIBuilderAction, onCompletion: @escaping ((ZBCoreBridgeBinderProtocols<Any>?, ZPVoidCompletion?) -> Void)) {
        
        switch action{
            case .list(let action):
            
            switch action{
                case .tap(_, let indexPath):
                    let category = categories?.object(at: indexPath!)
                    guard let id =  category?.id else{
                        return
                    }
                    if category?.sectionsCount != "0"{
                        onCompletion(KBCategoryBinder(path: .KBSubCategories(id: id)),nil)
                    }else if category?.articlesCount != "0"{
                        onCompletion(KBSubCategoryBinder(id: id),nil)
                    }
                default:
                    print("printz")
            }
            
        default:
            super.doPerform(builderAction: action, onCompletion: onCompletion)
    
        }
        
    }
    
    
}

extension KBCategoryBinder: SetProtocol{
    func setData<T>(categoriesModal: NSFetchedResultsController<T>?)  {
        print("set protocol")
            
        self.categories =  categoriesModal as? NSFetchedResultsController<CoreDataKBCategoriesModal>
        handler?(.refresh)
        loadingIndicator?(.end)
    }
    
    func notify(update: TableUpdate) {
        switch update{
            case .inserting(let indexPath, let newIndexPath):
                let changingIndexPath = IndexPath(row: indexPath.section, section: indexPath.row)
                guard let data = self.categories?.object(at: indexPath) else{
                    return
                }
            
                dbNotifier?(.list(data, indexPath , .insert, changingIndexPath))
            case .deleting(indexPath: let indexPath, newIndexPath: let newIndexPath):
                let changingIndexPath = IndexPath(row: indexPath.section, section: indexPath.row)
                guard let data = self.categories?.object(at: indexPath) else{
                    return
                }
                dbNotifier?(.list(data, changingIndexPath, .delete, newIndexPath))
            case .updating(indexPath: let indexPath, newIndexPath: let newIndexPath):
                guard let data = self.categories?.object(at: indexPath) else{
                    return
                }
                dbNotifier?(.list(data, indexPath, .update, newIndexPath))
            default:
                print("move")
        }
        
    }
}
