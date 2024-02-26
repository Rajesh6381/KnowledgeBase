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
    
    static let identifierCell = "CategoryCell"
    
    
    static func nibName() -> UINib{
        return UINib(nibName: "CategoryTableViewCell", bundle: nil)
    }
    
    
    func updateData(category: CoreDataKBCategoriesModal){
        
        if let logoUrl = category.logoUrl{
            DispatchQueue.global().async { [weak self] in
                
                if let data = try? Data(contentsOf: URL(string: logoUrl)!) {
                            if let image = UIImage(data: data){
                                DispatchQueue.main.async {
                                    self?.categoryImage.image =  image
                                    
                                }
                            }
                        }
                    }
        }
        
        
        categoryName.text = category.name
        categoryDescription.text = category.description
        
        if category.sectionsCount == "0" {
            categorySectionsLabel.isHidden = true
            CategorySectionsCount.isHidden = true
        }else{
            CategorySectionsCount.text = category.sectionsCount
        }
        categoryArticleCount.text = category.articlesCount
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
}
