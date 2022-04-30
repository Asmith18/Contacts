//
//  FirebaseStroageController.swift
//  notFirebase
//
//  Created by adam smith on 2/24/22.
//

import Foundation
import FirebaseStorage
import UIKit.UIImage

struct FirebaseStorageController {
    let storage = Storage.storage().reference()
    
    func save (_ imageData: Data, toContact contact: Contact) {
        storage.child(contact.imagePath).putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print(error)
                return
            }
            
            self.storage.child(contact.imagePath).downloadURL { url, error in
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
    
    func loadImage(from contact: Contact, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(contact.imagePath).getData(maxSize: 4000 * 4000) { data, error in
            if let error = error {
                completion(.failure(.failure(error)))
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data)
            else { completion(.failure(.noData)); return }
            completion(.success(image))
        }
    }
    
    func deleteImage(fromcontact contact: Contact) {
        storage.child(contact.imagePath).delete(completion: nil)
    }
}





