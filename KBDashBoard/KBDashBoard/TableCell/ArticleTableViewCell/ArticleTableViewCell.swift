//
//  ArticleTableViewCell.swift
//  KBDashBoard
//
//  Created by Rajesh R on 16/02/24.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    static let identifier = "ArticleCell"
    
    @IBOutlet var articleDescription: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: "ArticleTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
