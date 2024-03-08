//
//  KBArticleDetailBinder.swift
//  KBDashBoard
//
//  Created by Rajesh R on 06/03/24.
//

import Foundation
import ZohoDeskPlatformDataBridge
import CoreData

class KBArticleDetailBinder: KBDetailBinder{
    
    var articleDetails: NSFetchedResultsController<CoreDataKBArticleModal>?
    var articleId: String?
    
    init(id: String){
        super.init(identifier: .KBArticleDetailScreen)
        self.articleId = id
    }
    
    override func initialize(onCompletion: @escaping ((ZohoDeskPlatformDataBridge.ZPIntializeProgress) -> Void)) {
        super.initialize(onCompletion: onCompletion)
        if let id = articleId , articleDetails.isNil {
            let builder = Builder()
            builder.build(instance: self, categoriesPath: .KBArticleDetails(id: id))
        }
    }
    
    
    override func prepareData(of dataSourceType: ZohoDeskPlatformDataBridge.ZBDataSourceType) -> [ZohoDeskPlatformDataBridge.ZBDataItem] {
        
        switch dataSourceType{
            case .navigation(.getElement(let elements)):
                return navPrepareData(elements: elements, title: NavigationStrings.ArticleTitle.rawValue, likeCount: articleDetails?.object(at: IndexPath(row: 0, section: 0)).likeCount ?? "0", dislikeCount: articleDetails?.object(at: IndexPath(row: 0, section: 0)).dislikeCount ?? "0")
            case .container(.getElement(let elements)):
                elements.forEach({data in
                    guard let articles = articleDetails?.object(at: IndexPath(row: 0, section: 0)) else{
                        return
                    }
                
                    switch KBStrings.ArticleContainerKeys(rawValue: data.key){
                        case .Title:
                            data.value.plainString = articles.title ?? ""
                        case .WebView:
                            data.value.plainString = articles.answer?.htmlFormat()
                            data.didFinishWebViewLoading = {
                                if !self.articleDetails.isNil{
                                    self.loadingView?(.end)
                                }
                            }
                        case .CreatedDate:
                            data.value.plainString = articles.createdTime?.changeDateFormat()
                        default:
                            print("default container")
                    }
                })
                return elements
            
            default:
                return super.prepareData(of: dataSourceType)
    }
}

}

extension KBArticleDetailBinder: SetProtocol{
    func setData<T>(categoriesModal: NSFetchedResultsController<T>?) where T : NSManagedObject {
        print("setted")
        self.articleDetails = categoriesModal as? NSFetchedResultsController<CoreDataKBArticleModal>
        if !self.articleDetails.isNil{
            self.updateView?(.bottomNavigation)
            self.updateView?(.refresh)
        }
    }
    
    func notify(update: TableUpdate) {
        print("notification")
        self.updateView?(.bottomNavigation)
        self.updateView?(.refresh)
        
    }
    
    
}
