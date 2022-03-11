//
//  ContactsTableViewCell.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import UIKit
import RxSwift
import DomainLayer

protocol UITableViewCellRepresentable: UITableViewCell {
    func setup(with data: Any)
}

class ContactsTableViewCell: UITableViewCell, UITableViewCellRepresentable {
    
    static let nibName = "ContactsTableViewCell"
    static let identifier = "ContactsTableViewCell"
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        contactImage.layer.cornerRadius = contactImage.frame.size.width / 2
        contactImage.layer.masksToBounds = true
        contactImage.clipsToBounds = true
    }
    
    func setup(with data: Any) {
        if let contactElement = data as? ContactRepresentable {
            contactLabel.text = contactElement.name
            accessoryType = contactElement.isSelected ? .checkmark : .none
            contactImage.loadImage(contactElement.image)
           
        }
    }
}
