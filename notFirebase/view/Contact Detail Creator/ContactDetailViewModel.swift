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
    var imageURL: URL?
    
    init(contact: Contact? = nil) {
        self.contact = contact
    }
    
    func saveContact(image: UIImage) {
        guard let contact = contact else { return }
        ImageCache.shared.cache.setObject(image, forKey: contact.uuid as NSString)
        FirebaseController().saveLocation(contact)
        FirebaseStorageController().saveimageToContact(image: image, toContact: contact)
    }
}
