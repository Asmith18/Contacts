//
//  ContactTableViewController.swift
//  notFirebase
//
//  Created by adam smith on 4/30/22.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    var viewModel: ContactViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ContactViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchMyContacts()
        tableView.reloadData()
    }
    
    @IBAction func addContactButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ContactDetail", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "detail") as? ContactDetailViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        let result = viewModel.contactList[indexPath.row]
        cell.updateViews(contact: result)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let contact = viewModel.contactList[indexPath.row]
        let storyboard = UIStoryboard(name: "ContactDetail", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "detail") as? ContactDetailViewController else { return }
        viewController.viewModel = ContactDetailViewModel(contact: contact)
        viewController.viewModel.contact = viewModel.contactList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(viewController, animated: true)
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contactToDelete = viewModel.contactList[indexPath.row]
            viewModel.deleteContact(contact: contactToDelete)
            viewModel.contactList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "todetailContact",
//                let desination = segue.destination as? ContactDetailViewController {
//                    if let indexPath = tableView.indexPathForSelectedRow {
//                        let contactToSend = viewModel.contactList[indexPath.row]
//                        desination = contactToSend
//            }
//        }
    }
}

extension ContactTableViewController: ContactViewModelDelegate {
    func contactsHasData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
