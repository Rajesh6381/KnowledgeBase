//
//  ViewController.swift
//  KBDashBoard
//
//  Created by zoho on 09/02/24.
//

import UIKit
import ZohoDeskPortalKB





class SelectPlatformViewController: CommonViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func nativeKB(_ sender: Any) {
        let path =  KBCategoryPath.KBRootCategories
        let controller = Navigation.KBCategories(categories: nil, kbPath: path, identifier: .ArticleCategoryStroyBoard)
        self.navigate(navigation: controller, with: .push)
        
    }
    @IBAction func platformKBActions(_ sender: Any) {
        ZDPortalKB.show(withTitle: "Library" ,navigationMode: .push)
    }
    
}




