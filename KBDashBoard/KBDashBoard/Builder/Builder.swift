//
//  Builder.swift
//  KBDashBoard
//
//  Created by Rajesh R on 13/02/24.
//

import Foundation
import UIKit

final class Builder{
    
    static let kbCategoryInteractor = KBCategoryInteractor()
    
    
    
    static func build(instance: SetProtocol,categoriesPath: KBCategoryPath){
        
        kbCategoryInteractor.view = instance
        kbCategoryInteractor.getCategoriesData(kbPath: categoriesPath)
    }
    
}
