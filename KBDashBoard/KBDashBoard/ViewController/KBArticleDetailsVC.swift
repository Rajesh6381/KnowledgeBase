//
//  KBArticleDetailsViewController.swift
//  KBDashBoard
//
//  Created by Rajesh R on 29/02/24.
//

import UIKit
import CoreData
import WebKit

class KBArticleDetailsVC: CommonViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var DislikeButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var height: CGFloat?
    
    var articleDetail: NSFetchedResultsController<CoreDataKBArticleModal>?
    var articleId: String?
    
    let loadingView = UIActivityIndicatorView(style: .large)
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        toolBar()
        spinLoader(loadingSpinner: loadingView)
        stackView.layer.borderWidth = 1.0
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        
        loadingView.startAnimating()
        
        tableView.register(DateTableViewCell.nib(), forCellReuseIdentifier: DateTableViewCell.identifier)
        tableView.register(TitleTableViewCell.nib(), forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.register(WebViewTableViewCell.nib(), forCellReuseIdentifier: WebViewTableViewCell.identifier)
        
        if articleDetail.isNil && !articleId.isNil{
            let builder = Builder()
            builder.build(instance: self, categoriesPath: .KBArticleDetails(id: articleId!))
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateBottomBar(){
        guard let article = articleDetail?.object(at: IndexPath(row: 0, section: 0)) else{
            return
        }
        likeButton.titleLabel?.text =  article.likeCount ?? "0"
        DislikeButton.titleLabel?.text = article.dislikeCount ?? "0"
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let article =  self.articleDetail?.object(at: IndexPath(row: 0, section: 0)) else{
            return UITableViewCell()
        }
        
        switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
                cell.updateData(title: article.title ?? "")
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: WebViewTableViewCell.identifier, for: indexPath) as! WebViewTableViewCell
                cell.delegate = self
                cell.containerHeight.constant = height ?? 0.0
                cell.update(div: article.answer ?? "")
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
                cell.update(date: article.createdTime ?? "")
                return cell
        }
    }
    
}


extension KBArticleDetailsVC: SetProtocol, WebView{
    func webViewCellHeightDidChange(height: CGFloat) {
        if self.height.isNil {
            self.height = height
            self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            self.updateBottomBar()
        }else{
            self.loadingView.stopAnimating()
        }
    }
    
    func setData<T>(categoriesModal: NSFetchedResultsController<T>?) where T : NSManagedObject {
        print("data setted")
        
        self.articleDetail = categoriesModal as? NSFetchedResultsController<CoreDataKBArticleModal>
        self.tableView.beginUpdates()
        tableView.reloadData()
        self.tableView.endUpdates()
    }
    
    func notify(update: TableUpdate) {
        print("notify1")
        self.height = nil
        self.tableView.reloadData()
    }
}


