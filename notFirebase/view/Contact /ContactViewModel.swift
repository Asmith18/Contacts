//
//  ContactViewModel.swift
//  notFirebase
//
//  Created by adam smith on 4/30/22.
//

import Foundation

protocol ContactViewModelDelegate: ContactTableViewController {
    func contactsHasData()
}

class ContactViewModel {
    
    var contactList = [Contact]()
    var contact: Contact? {
        didSet {
            delegate?.contactsHasData()
        }
    }
    
    weak var delegate: ContactViewModelDelegate?
    init(delegate: ContactViewModelDelegate) {
        self.delegate = delegate
        fetchMyContacts()
    }
    
    func fetchMyContacts() {
        FirebaseController().getLocations() { result in
            switch result {
            case .success(let contacts):
                self.contactList = contacts
                self.delegate?.contactsHasData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteContact(contact: Contact) {
        FirebaseController().deleteLocation(contact)
    }
}
