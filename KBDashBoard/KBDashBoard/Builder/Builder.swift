//
//  Builder.swift
//  KBDashBoard
//
//  Created by Rajesh R on 13/02/24.
//

import Foundation
import UIKit

class Builder{
    
    static func build(instance: ArticleCategoryViewController){
        
        let useCase = UseCase()
        let presenter = KBCategoriesPresenter()
        useCase.presenter = presenter
        presenter.view = instance
        
        useCase.getCategoriesData()
        
    }
}
