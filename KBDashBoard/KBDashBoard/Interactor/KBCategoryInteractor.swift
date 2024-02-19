//
//  UseCase.swift
//  KBDashBoard
//
//  Created by Rajesh R on 13/02/24.
//

import Foundation
protocol GetData{
    func getCategoriesData(kbPath: KBCategoryPath)
}

class KBCategoryInteractor: GetData{
    
    
    var view: SetProtocol?
    
// paramQuery = "hasArticles=true&locale=eu&include=articlesCount%2CsectionsCount&portalId=edbsnace8901b67ed92219428dc84a50ab4f3ed89f4b283f2b51f152bb76c0879a94f"
    
    func getCategoriesData(kbPath: KBCategoryPath) {
        
        switch kbPath{
            case .KBRootCategories:
                NetworkManager.shared.request(endPoint: kbPath, modalType: DataModal<KBCategoriesModal>.self){ data in
                    self.view?.setData(categoriesModal: data?.data)// Data to view controller
                }
            
            case .KBSubCategories(_):
                NetworkManager.shared.request(endPoint: kbPath, modalType: KBCategoriesModal.self){ data in
                    self.view?.setData(categoriesModal: data?.child)
                }
            
            case .KBArticles(_):
                NetworkManager.shared.request(endPoint: kbPath, modalType: DataModal<KBArticlesModal>.self){ data in
                    self.view?.setData(categoriesModal: data?.data)
                }
        }
        
    }
}


