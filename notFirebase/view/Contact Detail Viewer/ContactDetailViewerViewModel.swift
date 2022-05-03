//
//  ContactDetailViewerViewModel.swift
//  notFirebase
//
//  Created by adam smith on 5/2/22.
//

import Foundation
import UIKit
import AVFoundation

protocol ContactDetailViewerViewModelDelegate: ContactDetailViewerViewController {
    func contactRecieved()
    func imagerecieved(image: UIImage)
}

class ContactDetailViewerViewModel {
    
    var contact: Contact?
    var contactList = [Contact]()
    var imageURL: URL?
    weak var delegate: ContactDetailViewerViewModelDelegate?
    
    init(delegate: ContactDetailViewerViewModelDelegate) {
        self.delegate = delegate
    }
    
    func saveContact(name: String, company: String?, phoneNumber: String?, notes: String?, profilePhoto: String?) {
        if let contact = contact {
            contact.name = name
            contact.company = company
            contact.phoneNumber = phoneNumber
            contact.notes = notes
            contact.profileImage = profilePhoto
            FirebaseController().saveLocation(contact)
        } else {
            guard let contact = contact else { return }
            FirebaseController().saveLocation(contact)
        }
    }
    
    func setImage(contact: Contact) {
        FirebaseStorageController().loadImage(from: contact) { [weak self] result in
            switch result {
            case .success(let image):
                self?.delegate?.imagerecieved(image: image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
