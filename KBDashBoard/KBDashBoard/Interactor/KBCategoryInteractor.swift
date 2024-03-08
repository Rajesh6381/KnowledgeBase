//
//  UseCase.swift
//  KBDashBoard
//
//  Created by Rajesh R on 13/02/24.
//

import Foundation
protocol Notify: AnyObject{
    func notifications(table: TableUpdate)
}

class KBCategoryInteractor: Notify{
    
    
    var view: SetProtocol?
    var coreData: CDManager?
    
    func notifications(table: TableUpdate){
        
        view?.notify(update: table)
    }
    
    
    @discardableResult
    func getCDdata(predicatePath: KBCategoryPath) -> Bool{
        if let data = self.coreData?.getData(from: predicatePath ), data.fetchedObjects?.count != 0 {
            print("has core data ")
            self.view?.setData(categoriesModal: data)
            return true
        }
        print("no core data")
        return false
    }
    
    
    func processData(kbPath: KBCategoryPath) {
        switch kbPath{
            case .KBRootCategories:
                processRootCategory(with: kbPath)
            case .KBSubCategories(_):
                processSubCategory(with: kbPath)
            case .KBArticles(_):
                processArticle(with: kbPath)
            case .KBArticleDetails(_):
                processArticleDetails(with: kbPath)
                
        }
    }
    

    
    func processRootCategory(with kbPath: KBCategoryPath){
        
        let hasData = getCDdata(predicatePath: kbPath)
        NetworkManager.shared.request(endPoint: kbPath, modalType: DataModal<KBCategoriesModal>.self){data in
            
            guard let coreData =  data?.data else{
                return
            }
            self.coreData?.syncData(modal: coreData, from: kbPath)
            if !hasData{
                print("hasData")
                self.getCDdata(predicatePath: kbPath)
            }
        }
    }
    
    func processSubCategory(with kbPath: KBCategoryPath){
        
        let hasData = getCDdata(predicatePath: kbPath)
        
        NetworkManager.shared.request(endPoint: kbPath, modalType: KBCategoriesModal.self){ kbcategories in
            guard let coreData =  kbcategories else{
                return
            }
            let subCatgoriesData = self.subCategories(categories: coreData)
            
            self.coreData?.syncData(modal: subCatgoriesData, from: kbPath)
            if !hasData{
                print("hasData")
                self.getCDdata(predicatePath: kbPath)
            }
        }
    }
    
    func processArticle(with kbPath: KBCategoryPath){
        let hasData = getCDdata(predicatePath: kbPath)
        NetworkManager.shared.request(endPoint: kbPath, modalType: DataModal<KBArticlesModal>.self){data in
            
            guard let article =  data?.data else{
                return
            }
            self.coreData?.syncData(modal: article, from: kbPath)
            if !hasData{
                print("hasData")
                self.getCDdata(predicatePath: kbPath)
            }
        }
    }
    
    func processArticleDetails(with kbPath: KBCategoryPath){
        let hasData = getCDdata(predicatePath: kbPath)
        
        NetworkManager.shared.request(endPoint: kbPath, modalType: KBArticlesModal.self){data in
            guard let articleDetail =  data else{
                return
            }
            print(articleDetail)
            self.coreData?.syncData(modal: [articleDetail], from: kbPath)
            print("update ")
            
            //self.getCDdata(predicatePath: kbPath)
            
            
        }
    }
    
    
    

}

extension KBCategoryInteractor{
    
    // To Convert the tree structes of root category to list of child
    func subCategories(categories: KBCategoriesModal) -> [KBCategoriesModal]{
        var children: [KBCategoriesModal] = []
        if let child = categories.child{
            let _ = child.map({data in
                children.append(data)
            })
        }
        var index = 0
        var temp = children[index]
        
        while (index < children.count){
            if let child = temp.child{
               let _ = child.map({
                    data in children.append(data)
                })
            }
            index = index + 1
            if index < children.count{
                temp = children[index]
            }
        }
        print("children count :  \(children.count)")
        return children
    }
}
       



