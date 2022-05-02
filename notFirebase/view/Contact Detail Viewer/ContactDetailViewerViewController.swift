//
//  ContactDetailViewerViewController.swift
//  notFirebase
//
//  Created by adam smith on 5/2/22.
//

import UIKit

class ContactDetailViewerViewController: UIViewController {
    
    //MARK: -
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var viewModel: ContactDetailViewerViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let contact = viewModel.contact else { return }
        
        viewModel.setImage(contact: contact)
        self.nameTextField.text = contact.name
        self.companyTextField.text = contact.company
        self.notesTextView.text = contact.notes
        self.phoneNumberTextField.text = contact.phoneNumber
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let profileImage = profileImage.image else { return }
        
        guard let name = nameTextField.text,
              let compnay = companyTextField.text,
              let phoneNumber = phoneNumberTextField.text,
              let notes = notesTextView.text else { return }
        let contact = Contact(name: name, company: compnay, phoneNumber: phoneNumber, notes: notes, profilePhoto: "\(profileImage)")
        
        viewModel.saveContact(name: name, company: compnay, phoneNumber: phoneNumber, notes: notes, profilePhoto: "\(profileImage)")
        viewModel.contactList.append(contact)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ContactDetailViewerViewController: ContactDetailViewerViewModelDelegate {
    func contactRecieved() {
        updateViews()
    }
    
    func imagerecieved(image: UIImage) {
        profileImage.image = image
    }
}
