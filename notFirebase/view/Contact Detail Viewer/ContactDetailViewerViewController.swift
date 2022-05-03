//
//  ContactDetailViewerViewController.swift
//  notFirebase
//
//  Created by adam smith on 5/2/22.
//

import UIKit
import MessageUI

class ContactDetailViewerViewController: UIViewController {
    
    //MARK: -
    @IBOutlet weak var contactNameHeaderText: UILabel!
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
        self.contactNameHeaderText.text = contact.name
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
    
    @IBAction func messagebuttonTapped(_ sender: Any) {
        guard MFMessageComposeViewController.canSendText() else {
            print("Device is not capable to send messages")
            return
        }
        
        let composer = MFMessageComposeViewController()
        composer.messageComposeDelegate = self
        composer.recipients = [phoneNumberTextField.text ?? ""]
        composer.subject = "Sent from my Iphone"
        present(composer, animated: true)
    }
}

extension ContactDetailViewerViewController: ContactDetailViewerViewModelDelegate, MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("failed")
        case .sent:
            print("sent")
        default:
            print("UNKOWN")
        }
        controller.dismiss(animated: true)
    }
    
    func contactRecieved() {
        updateViews()
    }
    
    func imagerecieved(image: UIImage) {
        profileImage.image = image
    }
}
