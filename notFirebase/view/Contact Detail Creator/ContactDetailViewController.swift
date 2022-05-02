//
//  ContactDetailViewController.swift
//  notFirebase
//
//  Created by adam smith on 4/30/22.
//

import UIKit

class ContactDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var phoneNumbertextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var ProfileImage: UIImageView!
    
    var viewModel: ContactDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ContactDetailViewModel()
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let profileImage = ProfileImage.image else { return }
        
        guard let name =  nameTextfield.text,
              let compnay = companyTextField.text,
              let phoneNumber = phoneNumbertextField.text,
              let notes = notesTextView.text else { return }
        
        let contact = Contact(name: name, company: compnay, phoneNumber: phoneNumber, notes: notes, profilePhoto: "\(profileImage)")
        
        viewModel.saveContact(contact: contact)
        viewModel.contactList.append(contact)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func messagebuttonTapped(_ sender: Any) {
        
    }
    
    @IBAction func imagePickerButtonTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        viewModel.profileImage = imageURL
        self.ProfileImage.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
