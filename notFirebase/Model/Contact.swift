//
//  Contact.swift
//  notFirebase
//
//  Created by adam smith on 4/30/22.
//

import Foundation
import UIKit

class Contact {
    
    let name: String
    let company: String?
    let phoneNumber: String?
    let notes: String?
    let profileImage: String?
    let uuid: String
    
    enum Keys {
        static let name = "name"
        static let company = "company"
        static let phoneNumber = "phoneNumber"
        static let notes = "notes"
        static let profileImage = "profileImage"
        static let uuid = "uuid"
        static let collectionType = "Contacts"
    }
    
    var imagePath: String {
        "images/\(self.uuid)"
    }
    
    var contactData: [String: Any] {
        [Keys.name: self.name,
         Keys.company: self.company,
         Keys.phoneNumber: self.phoneNumber,
         Keys.notes: self.notes,
         Keys.profileImage: self.profileImage as Any,
         Keys.uuid: self.uuid]

    }
    
    init(name: String, company: String?, phoneNumber: String?, notes: String?, profilePhoto: String?, uuid: String = UUID().uuidString) {
        self.name = name
        self.company = company
        self.phoneNumber = phoneNumber
        self.notes = notes
        self.profileImage = profilePhoto
        self.uuid = uuid
    }
    
    
    init?(fromDictionary dictionary: [String: Any]) {
        guard let name = dictionary[Keys.name] as? String,
              let company = dictionary[Keys.company] as? String,
              let phoneNumber = dictionary[Keys.phoneNumber] as? String,
              let notes = dictionary[Keys.notes] as? String,
              let profileImage = dictionary[Keys.profileImage] as? String,
              let uuid = dictionary[Keys.uuid] as? String
        else { return nil}
        
        self.name = name
        self.company = company
        self.notes = notes
        self.phoneNumber = phoneNumber
        self.profileImage = profileImage
        self.uuid = uuid
    }
}
