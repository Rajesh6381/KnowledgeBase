//
//  Common.swift
//  KBDashBoard
//
//  Created by Rajesh R on 19/02/24.
//

import Foundation
import UIKit
import CoreData

enum NavigationAnimationType{
    case push,present
}

enum Navigation{
    case KBCategories(categories: NSFetchedResultsController<CoreDataKBCategoriesModal>?, kbPath: KBCategoryPath?, identifier: StoryBoardIdentifier)
    case KBArticle(categoryId: String, identifier: StoryBoardIdentifier)
}



class CommonViewController: UIViewController{
    
    public func navigate(navigation: Navigation,with animation: NavigationAnimationType){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var controller: UIViewController?
        
        switch navigation{
            case .KBCategories(let categories,let kbPath ,let identifier):
                let vc =  storyBoard.instantiateViewController(withIdentifier: identifier.rawValue) as! ArticleCategoryViewController
                vc.categories = categories
                vc.kbPath = kbPath
                controller = vc
            
            case .KBArticle(let categoryId,let identifier):
                let  vc =  storyBoard.instantiateViewController(withIdentifier: identifier.rawValue) as! ArticleListViewController
                vc.categoryId = categoryId
                controller = vc
        }
        
        guard let viewController = controller else{
            return
        }
        animateNavigation(uiViewController: viewController, with: animation)
    }
    
    func animateNavigation(uiViewController: UIViewController,with animation: NavigationAnimationType){
        switch animation {
            case .push:
                self.navigationController?.pushViewController(uiViewController, animated: true)
            case .present:
                self.navigationController?.present(uiViewController, animated: true)
        }
    }
}


// MARK: - EXTENSION

extension UIViewController: UISearchControllerDelegate{
    
    func searchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.tintColor = UIColor(.white)
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = #colorLiteral(red: 0.100538753, green: 0.4378237724, blue: 0.3871613145, alpha: 1)
    }
    
    func spinLoader(loadingSpinner: UIActivityIndicatorView){
        
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.tintColor = .black
        loadingSpinner.center = self.view.center
        view.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
    }
}

extension CommonViewController{
    
}

