//
//  ContactsTableViewCell.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    static let nibName = "ContactsTableViewCell"
    static let identifier = "ContactsTableViewCell"
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
