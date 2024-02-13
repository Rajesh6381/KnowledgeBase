//
//  KBCategoriesPresenter.swift
//  KBDashBoard
//
//  Created by Rajesh R on 13/02/24.
//

import Foundation

protocol Presenter{
    func categoriesData(modalData: KBCategoriesModal?)
}

class KBCategoriesPresenter: Presenter{
    
     var view: ArticleCategoryView?
    
    // set data to the view controller modified
    func categoriesData(modalData: KBCategoriesModal?){
        view?.setData(categoriesModal: modalData?.data)
    }
}
