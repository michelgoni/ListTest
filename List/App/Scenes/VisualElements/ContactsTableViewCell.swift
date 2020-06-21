//
//  ContactsTableViewCell.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import UIKit

protocol UITableViewCellRepresentable: UITableViewCell {
    func setup(with data: Any)
}

class ContactsTableViewCell: UITableViewCell {
    
    static let nibName = "ContactsTableViewCell"
    static let identifier = "ContactsTableViewCell"
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension ContactsTableViewCell: UITableViewCellRepresentable {
    
    func setup(with data: Any) {
        if let contactElement = data as? ContactRepresentable {
            contactLabel.text = contactElement.name
        }
    }
}
