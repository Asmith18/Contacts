//
//  Contact.swift
//  notFirebase
//
//  Created by adam smith on 2/23/22.
//

import Foundation
import UIKit
import Contacts

class Contact {
    
    enum Key {
        static let collectionType = "locations"
        static let firstName = "firstName"
        static let company = "company"
        static let note = "note"
        static let contactDate = "contactDate"
        static let uuid = "uuid"
        static let imageURL = "imageURL"
        static let phoneNumber = "phoneNumber"
    }
    
    var imagePath: String {
        "images/\(self.uuid)"
    }
    
    
    var firstName: String
    var company: String
    var note: String
    let contactDate: Date
    let uuid: String
    var phoneNumber: Int

    
    var locationData: [String: Any] {
        [Key.firstName : self.firstName,
         Key.company : self.company,
         Key.note : self.note,
         Key.contactDate : self.contactDate.timeIntervalSince1970,
         Key.uuid : self.uuid,
         Key.phoneNumber : self.phoneNumber]
    }
    
    init(firstName: String, company: String, note: String, contactDate: Date = Date(), uuid: String = UUID().uuidString, phoneNumber: Int = Int() ) {
        
        self.firstName = firstName
        self.company = company
        self.note = note
        self.contactDate = contactDate
        self.uuid = uuid
        self.phoneNumber = phoneNumber
        
    }
    
    init?(fromDictionary dictionary: [String: Any]) {
        guard let fistName = dictionary[Key.firstName] as? String,
              let company = dictionary[Key.company] as? String,
              let note = dictionary[Key.note] as? String,
              let dateNum = dictionary[Key.contactDate] as? Double,
              let uuid = dictionary[Key.uuid] as? String,
              let phoneNumber = dictionary[Key.phoneNumber] as? Int
        else { return nil}
        
        self.firstName = fistName
        self.company = company
        self.note = note
        self.contactDate = Date(timeIntervalSince1970: dateNum)
        self.uuid = uuid
        self.phoneNumber = phoneNumber
    }
}

