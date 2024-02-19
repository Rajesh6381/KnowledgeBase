//
//  ArticleListViewController.swift
//  KBDashBoard
//
//  Created by Rajesh R on 16/02/24.
//

import UIKit

protocol ArticleListViewProtocol{
    func getArtilceData(data: [KBArticlesModal]?)
}

class ArticleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var articleList: [KBArticlesModal] = []
    var categoryId: String?
    
    
    let loadingView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = categoryId{
            Builder.build(instance: self, categoriesPath: KBCategoryPath.KBArticles(id: id))
        }
        
        spinLoader(loadingSpinner: loadingView)
        
        //Search bar extension
        searchBar()
        // tableView
        tableView.register(ArticleTableViewCell.nib(), forCellReuseIdentifier: ArticleTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.backButtonTitle = "Back"
        navigationItem.title = "Hello World"
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexpath: IndexPath ) -> UITableViewCell{
        print("hello world")
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexpath) as! ArticleTableViewCell
        cell.articleDescription.text = articleList[indexpath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ArticleListViewController: SetProtocol{
    
    func setData<T>(categoriesModal: [T]?) where T : Decodable {
        
        if let article = categoriesModal as? [KBArticlesModal]{
            self.articleList = article
            self.tableView.reloadData()
            self.loadingView.stopAnimating()
        }
    }
    
//    func getArtilceData(data: [KBArticlesModal]?) {
//        if let article = data{
//            self.articleList = article
//            self.tableView.reloadData()
//            self.loadingView.stopAnimating()
//        }
//    }
    
}
