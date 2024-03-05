//
//  DateTableViewCell.swift
//  KBDashBoard
//
//  Created by Rajesh R on 04/03/24.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    static let identifier = "DateTableViewCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: DateTableViewCell.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(date: String){
        if let formatterDate = date.changeDateFormat(){
            dateLabel.text = formatterDate
        }
        
    }
    
}
