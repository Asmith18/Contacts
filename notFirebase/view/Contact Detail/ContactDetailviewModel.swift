//
//  ContactDetailviewModel.swift
//  notFirebase
//
//  Created by adam smith on 4/30/22.
//

import Foundation
import UIKit

class ContactDetailViewModel {
    
    var contact: Contact?
    var contactList = [Contact]()
    var profileImage: URL?
    
    init(contact: Contact? = nil) {
        self.contact = contact
    }
    
    func saveContact(contact: Contact) {
         FirebaseController().saveLocation(contact)
    }
}
