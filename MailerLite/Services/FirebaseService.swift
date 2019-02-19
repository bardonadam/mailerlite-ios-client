//
//  FirebaseService.swift
//  MailerLite
//
//  Created by Adam Bardon on 18/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

// MARK: - FirebaseService

class FirebaseService {
    private let firestore: Firestore
    
    init(firestore: Firestore) {
        self.firestore = firestore
    }
    
    typealias SubscribersHandler = (Result<[Subscriber], FirestoreError>) -> Void
    
    /// Loads all subscribers as an array of **FIRQueryDocumentSnapshots** and decodes them to array of **Subscribers**
    ///
    /// - Parameter handler: block to handle once the subscribers have been loaded.
    func getSubscribers(completion handler: @escaping SubscribersHandler) {
        firestore.collection(Constants.FirestoreCollections.Subscribers).getDocuments(completion: { (snapshot, error) in
            if let _ = error {
                handler(.failure(.responseError))
            }
            else {
                if let documents = snapshot?.documents {
                    var subscribers: [Subscriber] = []
                    for document in documents {
                        do {
                            let subscriber = try Subscriber(documentSnapshot: document)
                            subscribers.append(subscriber)
                        }
                        catch let error as FirestoreError {
                            handler(.failure(error))
                        }
                        catch {
                            handler(.failure(.unknown))
                        }
                    }
                    
                    handler(.success(subscribers))
                }
                else {
                    handler(.failure(.failedToGetDocuments))
                }
            }
        })
    }
}

// MARK: - FirebaseService errors

extension FirebaseService {
    /// - responseError: returned when getting documents from Firestore fails
    /// - invalidDocument: returned when decoding of **QuerySnapshot's document** into **Subscriber** failed
    /// - failedToGetDocuments: returned when **QuerySnapshot's documents** are **nil**
    /// - unknown
    enum FirestoreError: Error {
        case responseError
        case invalidDocument
        case failedToGetDocuments
        case unknown
    }
}
