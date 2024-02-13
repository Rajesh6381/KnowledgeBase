//
//  ArticleCategoryViewController.swift
//  KBDashBoard
//
//  Created by zoho on 09/02/24.
//

import UIKit
protocol ArticleCategoryView{
    func setData(categoriesModal: [KBCategoriesModals]?)
}


class ArticleCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchControllerDelegate {
    
    var categories: [KBCategoriesModals]?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Search Bar
        searchController.delegate = self
        searchController.searchBar.tintColor = UIColor(.white)
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = #colorLiteral(red: 0.100538753, green: 0.4378237724, blue: 0.3871613145, alpha: 1)
        
        //register table cell
        tableView.register(CategoryTableViewCell.nibName(), forCellReuseIdentifier: "CategoryCell")
        
        //Table view
        tableView.delegate = self
        tableView.dataSource = self
        
        Builder.build(instance: self)
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        cell.categoryDescription.text = "dfsdfs"
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension ArticleCategoryViewController: ArticleCategoryView{
    
    
    
    func setData(categoriesModal: [KBCategoriesModals]?) {
        self.categories = categoriesModal
        print("Called")
        print(self.categories)
    }
}




