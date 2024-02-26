//
//  ArticleListViewController.swift
//  KBDashBoard
//
//  Created by Rajesh R on 16/02/24.
//

import UIKit
import CoreData

class ArticleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var articleList: NSFetchedResultsController<CoreDataKBArticleModal>?
    var categoryId: String?
    
    
    let loadingView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = categoryId{
            let builder = Builder()
            builder.build(instance: self, categoriesPath: KBCategoryPath.KBArticles(id: id))
        }
        
        if articleList.isNil{
            spinLoader(loadingSpinner: loadingView)
        }
        
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
        let sectionInfo = articleList?.sections![section]
            return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexpath: IndexPath ) -> UITableViewCell{
        print("hello world")
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexpath) as! ArticleTableViewCell
        cell.articleDescription.text = self.articleList?.object(at: indexpath).title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension ArticleListViewController: SetProtocol{
    func setData<T>(categoriesModal: NSFetchedResultsController<T>?) where T : NSManagedObject {
        print("Article data 1")
        if let article = categoriesModal as? NSFetchedResultsController<CoreDataKBArticleModal>{
            print("article data")
            self.articleList = article
            self.tableView.reloadData()
            self.loadingView.stopAnimating()
        }
    }
    
 
    
    func notify(update: TableUpdate) {
        print("article update")
        
        if ((self.articleList?.fetchedObjects?.isEmpty) != nil) {
            switch update{
            case .inserting(let indexPath,_):
                print("view insert")
                tableView.insertRows(at: [indexPath], with: .fade)
            case .deleting(let indexPath,_):
                print("view delete")
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .moving(let indexPath,let  newIndexPath):
                break
            case .updating(let indexPath,_):
                print("view delete")
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
    

    

//    func setData<T>(categoriesModal: [T]?) where T : Decodable {
//        
//        if let article = categoriesModal as? [KBArticlesModal]{
//            self.articleList = article
//            self.tableView.reloadData()
//            self.loadingView.stopAnimating()
//        }
//    }

    
}
