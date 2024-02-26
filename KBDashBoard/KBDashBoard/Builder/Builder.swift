//
//  Builder.swift
//  KBDashBoard
//
//  Created by Rajesh R on 13/02/24.
//

import Foundation
import UIKit

final class Builder{
    
    func build(instance: SetProtocol,categoriesPath: KBCategoryPath){
         
        let interactor = KBCategoryInteractor()
        let categoriesCD = KBCategoriesCDManager()
        let articleCD = KBArticleCDManager()
        
        switch categoriesPath{
            case .KBRootCategories,.KBSubCategories(_):
                categoriesCD.interactor = interactor
                interactor.coreData = categoriesCD
            case .KBArticles(_):
                articleCD.interactor = interactor
                interactor.coreData = articleCD
                print("instance 2")
        }
        
         
        interactor.view = instance
        
        interactor.processData(kbPath: categoriesPath)
    }
    
}
