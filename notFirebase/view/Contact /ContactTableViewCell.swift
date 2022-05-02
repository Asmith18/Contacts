//
//  ContactTableViewCell.swift
//  notFirebase
//
//  Created by adam smith on 5/1/22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func updateViews(contact: Contact) {
        nameLabel.text = contact.name
    }

}
