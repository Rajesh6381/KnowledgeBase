//
//  TitleTableViewCell.swift
//  KBDashBoard
//
//  Created by Rajesh R on 01/03/24.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    
    static func nib() -> UINib{
        
        return UINib(nibName: TitleTableViewCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(title: String){
        self.title.text = title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
