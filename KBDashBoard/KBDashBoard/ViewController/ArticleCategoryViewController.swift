//
//  ArticleCategoryViewController.swift
//  KBDashBoard
//
//  Created by zoho on 09/02/24.
//

import UIKit
protocol SetProtocol{
    func setData<T: Decodable>(categoriesModal: [T]?)
}

class ArticleCategoryViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories: [KBCategoriesModal]?
    var kbPath: KBCategoryPath?
    
    @IBOutlet weak var tableView: UITableView!
    let loadingView = UIActivityIndicatorView(style: .large)

    
    override func viewDidLoad(){
        super.viewDidLoad()
        //Loading indicator
        
        if self.categories.isNil {
            spinLoader(loadingSpinner: loadingView)
        }

        //Navigation Search Bar
        searchBar()
        
        //register table cell
        tableView.register(CategoryTableViewCell.nibName(), forCellReuseIdentifier: CategoryTableViewCell.identifierCell)
        
        //Table view
        tableView.delegate = self
        tableView.dataSource = self
        
        if let pathAvailable  =  self.kbPath, categories.isNil{
            Builder.build(instance: self,categoriesPath: pathAvailable)
        }
        
      }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer  = UIView()
        footer.backgroundColor = .clear
        return footer
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let data = self.categories else{
            return 0
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifierCell, for: indexPath) as! CategoryTableViewCell
        guard let unWrapData = self.categories else{
            return cell
        }
        cell.updateData(category: unWrapData[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = categories else{
            return
        }
        
        if category[indexPath.section].sectionsCount != "0" {
            let path = KBCategoryPath.KBSubCategories(id: category[indexPath.section].id)
            let controller = Navigation.KBCategories(categories: category[indexPath.section].child ?? nil, kbPath: path, identifier: .ArticleCategoryStroyBoard)
            self.navigate(navigation: controller, with: .push)
            
        }else {
            let categoryId = category[indexPath.section].id
            let path = KBCategoryPath.KBArticles(id: categoryId)
            let controller = Navigation.KBArticle(categoryId: categoryId, identifier: .ArticleList)
            self.navigate(navigation: controller, with: .push)
        }
    }
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        //hide the table view
        if self.categories.isNil{
            self.tableView.isHidden = true
        }
    }
}

extension ArticleCategoryViewController: SetProtocol{
    
    func setData<T: Decodable>(categoriesModal: [T]?)  {
        self.categories = categoriesModal as? [KBCategoriesModal]
        print("Called")
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.tableView.isHidden = false
        self.loadingView.stopAnimating()
    }
    
//    
//    func setData(categoriesModal: [KBCategoriesModals]?) {
//        self.categories = categoriesModal
//        print("Called")
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//        self.tableView.isHidden = false
//        self.loadingView.stopAnimating()
//        
//        
//    }
}





