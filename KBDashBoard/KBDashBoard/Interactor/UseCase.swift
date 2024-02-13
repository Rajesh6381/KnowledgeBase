//
//  UseCase.swift
//  KBDashBoard
//
//  Created by Rajesh R on 13/02/24.
//

import Foundation
protocol GetData{
    func getCategoriesData()
}



class UseCase: GetData{
    
    
    var presenter: Presenter?
    
    
    func getCategoriesData() {
        
        NetworkManager.shared.request(PathUrl.KBCategories, modalType: KBCategoriesModal.self, parametersQuery: "hasArticles=true&locale=eu&include=articlesCount%2CsectionsCount&portalId=edbsnace8901b67ed92219428dc84a50ab4f3ed89f4b283f2b51f152bb76c0879a94f"){ data in
            
            self.presenter?.categoriesData(modalData: data)
        }

        
        
        
    }
    
    
}




