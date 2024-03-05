//
//  ArticleCategoryViewController.swift
//  KBDashBoard
//
//  Created by zoho on 09/02/24.
//

import UIKit
import CoreData
protocol SetProtocol{
    func setData<T: NSManagedObject>(categoriesModal: NSFetchedResultsController<T>?)
    func notify(update: TableUpdate)
}


class KBCategoryViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var categories: NSFetchedResultsController<CoreDataKBCategoriesModal>?
    var kbPath: KBCategoryPath?
    
    @IBOutlet weak var tableView: UITableView!
    let loadingView = UIActivityIndicatorView(style: .large)

    
    override func viewDidLoad(){
        super.viewDidLoad()
        //Navigation Search Bar
        searchBar()
        toolBar()
        
        if categories.isNil {
            print("nill")
            spinLoader(loadingSpinner: loadingView)
        }
        
        
        //register table cell
        tableView.register(CategoryTableViewCell.nibName(), forCellReuseIdentifier: CategoryTableViewCell.identifierCell)
        
        //Table view
        tableView.delegate = self
        tableView.dataSource = self
        
        if let pathAvailable  =  self.kbPath, self.categories == nil{
            print("instancr is calling")
            let builder = Builder()
            builder.build(instance: self,categoriesPath: pathAvailable)
        }
        
      }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer  = UIView()
        footer.backgroundColor = .clear
        return footer
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("rows")
        let sectionInfo = self.categories?.sections![section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifierCell, for: indexPath) as! CategoryTableViewCell
        
        guard let data = self.categories else {
            return cell
        }
        
        
        cell.updateData(category: data.object(at: indexPath) )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = self.categories else{
            return
        }
        
        if category.object(at: indexPath).sectionsCount != "0" {
            print("again")
            print(category.object(at: indexPath).id)
            let path = KBCategoryPath.KBSubCategories(id: category.object(at: indexPath).id)
            let controller = Navigation.KBCategories(categories: nil , kbPath: path, identifier: .ArticleCategoryStroyBoard)
           self.navigate(navigation: controller, with: .push)
            
        }else {
            print("article page \n\n")
            let categoryId = category.object(at: indexPath).id
            print(categoryId)
            print(category.object(at: indexPath).webUrl)
            let path = KBCategoryPath.KBArticles(id: categoryId)
            let controller = Navigation.KBArticle(id: categoryId, identifier: .ArticleList,isDetail: false)
            self.navigate(navigation: controller, with: .push)
        }
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.isNavigationBarHidden = false
        //hide the table view
        if self.categories.isNil{
            self.tableView.isHidden = true
        }
    }
}

extension KBCategoryViewController: SetProtocol{
    func setData<T>(categoriesModal: NSFetchedResultsController<T>?) where T : NSManagedObject {
        print("set protocol")
        
        if self.categories?.fetchedObjects?.count != 0{
            print("done")
            self.categories =  categoriesModal as? NSFetchedResultsController<CoreDataKBCategoriesModal>
            print(self.categories?.fetchedObjects?.count)
            self.tableView.reloadData()
        }else{
            self.categories =  categoriesModal as? NSFetchedResultsController<CoreDataKBCategoriesModal>
        }
        
        self.tableView.isHidden = false
        self.loadingView.stopAnimating()
    }
    
    
    func notify(update: TableUpdate) {
        print("update")
        
            self.loadingView.stopAnimating()
            self.tableView.isHidden = false
        if ((self.categories?.fetchedObjects?.isEmpty) != nil) {
            
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
    

}








