//
//  Common.swift
//  KBDashBoard
//
//  Created by Rajesh R on 19/02/24.
//

import Foundation
import UIKit
import CoreData
import WebKit

enum NavigationAnimationType{
    case push,present
}

enum Navigation{
    case KBCategories(categories: NSFetchedResultsController<CoreDataKBCategoriesModal>?, kbPath: KBCategoryPath?, identifier: StoryBoardIdentifier)
    case KBArticle(id: String, identifier: StoryBoardIdentifier,isDetail: Bool)
}



class CommonViewController: UIViewController{
    
    public func navigate(navigation: Navigation,with animation: NavigationAnimationType){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var controller: UIViewController?
        
        switch navigation{
            case .KBCategories(let categories,let kbPath ,let identifier):
                let vc =  storyBoard.instantiateViewController(withIdentifier: identifier.rawValue) as! KBCategoryViewController
                vc.categories = categories
                vc.kbPath = kbPath
                controller = vc
            
            case .KBArticle(let id,let identifier,let isDetail):
                if isDetail{
                    let vc = storyBoard.instantiateViewController(withIdentifier: identifier.rawValue) as! KBArticleDetailsVC
                    vc.articleId = id
                    controller = vc
                }else{
                    let  vc =  storyBoard.instantiateViewController(withIdentifier: identifier.rawValue) as! KBArticleViewController
                    vc.categoryId = id
                    controller = vc
                }
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
    
    func toolBar(){
        self.navigationController?.toolbar.scrollEdgeAppearance?.backgroundColor = .white
        self.navigationController?.toolbar.standardAppearance.backgroundColor = .white
        let titleLabel = UILabel()
        let attribute = NSMutableAttributedString(string: "Powered By ",attributes: [.font: UIFont.systemFont(ofSize: 15)])
        let asapImage = NSAttributedString(string: "\u{e91b} ", attributes: [
                    .font: UIFont.systemFont(ofSize: 15),
                    .foregroundColor: UIColor.white,
                    .baselineOffset: NSNumber(value: 2)
                ])
        let lastString = NSAttributedString(string: "ASAP",attributes: [.font: UIFont.systemFont(ofSize: 15)])
        attribute.append(asapImage)
        attribute.append(lastString)
        titleLabel.attributedText = attribute
        titleLabel.textColor = UIColor.black.withAlphaComponent(0.7)

        let titleItem = UIBarButtonItem(customView: titleLabel)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        self.toolbarItems = [flexSpace, titleItem, flexSpace]
        
        let view = UIView()
        let button = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        self.tabBarItem = button
    }
}


