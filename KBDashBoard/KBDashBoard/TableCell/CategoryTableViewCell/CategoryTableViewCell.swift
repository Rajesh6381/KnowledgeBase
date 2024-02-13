//
//  CategoryTableCellTableViewCell.swift
//  KBDashBoard
//
//  Created by Rajesh R on 12/02/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryDescription: UILabel!
    
    @IBOutlet weak var categoryArticleCount: UILabel!
    @IBOutlet weak var categoryArticleLabel: UILabel!
    
    @IBOutlet weak var categorySectionsLabel: UILabel!
    @IBOutlet weak var CategorySectionsCount: UILabel!
    
    static let  nibIdentifier = "CategoryTableViewCell"
    
    
    static func nibName() -> UINib{
        return UINib(nibName: CategoryTableViewCell.nibIdentifier, bundle: nil)
    }
    
    
    func removeSubViews(){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
}
