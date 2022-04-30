//
//  FirebaseController.swift
//  notFirebase
//
//  Created by adam smith on 2/23/22.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore


//Can be here instead of its own file. Could add as its own file for brevity. Can stay here since only used/refd by this file
enum FirebaseError: LocalizedError {
    case failure(Error)
    case noData
    case failedToDecode
    
    var description: String {
        switch self {
        case .failure(let error):
            return "\(error.localizedDescription) -> \(error)"
        case .noData:
            return "No data found!"
        case .failedToDecode:
            return "Unable to decode data"
        }
    }
}

struct FirebaseController {
    let dataBase = Firestore.firestore()
    
    func saveLocation(_ location: Contact) {
        dataBase.collection(Contact.Keys.collectionType).document(location.uuid).setData(location.contactData)
    }
    
    func deleteLocation(_ location: Contact) {
        dataBase.collection(Contact.Keys.collectionType).document(location.uuid).delete()
        FirebaseStorageController().deleteImage(fromcontact: location)
    }
    
    func getLocations(completion: @escaping (Result<[Contact], FirebaseError>) -> Void) {
        dataBase.collection(Contact.Keys.collectionType).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(.failure(error)))
                return
            }
            
            guard let data = snapshot?.documents else { completion(.failure(.noData)); return }
            let dataArray = data.compactMap({ $0.data() })
            let locationArray = dataArray.compactMap({ Contact(fromDictionary: $0 )})
            completion(.success(locationArray))
        }
    }
}
//        //Fetching the data from the real time database. Specified by the child key "location"
//        ref.child(Contact.Key.collectionType).getData { error, snapshot in
//            //checking to see if there was an error, if so, we complete with a failure and return out of the function.
//            if let error = error {
//                completion(.failure(.failure(error)))locationData
//                return
//            }
//            //checking to see if we have data, if so, completing with a dictionary of type dictionary
//            guard let data = snapshot.value as? [String: [String: Any]] else { completion(.failure(.noData)); return }
//
//            //gets the values from our data dictionary and turns them into an array.
//            let dataArray = Array(data.values)
//            //Transforms our array of dictionaries into an array of locations
//            let locations = dataArray.compactMap({ Contact(fromDictionary: $0) })
//            //sorting locations by date
//            let sortedLocations = locations.sorted(by: { $0.firstName > $1.firstName })
//            //completing with our sorted locations
//            completion(.success(sortedLocations))
//        }

