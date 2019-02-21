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
    typealias SetSubscriberHandler = (Result<String?, FirestoreError>) -> Void
    
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
                            handler(.failure(.other(error)))
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
    
    /// Adds new **Subscriber** and returns its id in completion handler
    ///
    /// - Parameters:
    ///   - subscriber
    ///   - handler: block to handle once the subscriber has been added.
    func addSubscriber(_ subscriber: Subscriber, completion handler: @escaping SetSubscriberHandler) {
        var ref: DocumentReference? = nil
        ref = firestore.collection(Constants.FirestoreCollections.Subscribers).addDocument(data: subscriber.asDictionary, completion: { error in
            if let error = error {
                handler(.failure(.other(error)))
            }
            else if let ref = ref {
                handler(.success(ref.documentID))
            }
            else {
                handler(.failure(.noDocumentId))
            }
        })
    }
    
    /// - Parameters:
    ///   - subscriber
    ///   - handler: block to handle once the subscriber has been updated
    func updateSubscriber(_ subscriber: Subscriber, completion handler: @escaping SetSubscriberHandler) {
        let subscriberRef = firestore.collection(Constants.FirestoreCollections.Subscribers).document(subscriber.id)
        
        subscriberRef.updateData([
            "email": subscriber.email,
            "name": subscriber.name,
            "state": subscriber.state.rawValue,
            "updated": Date()
        ]) { error in
            if let error = error {
                handler(.failure(.other(error)))
            } else {
                handler(.success(nil))
            }
        }
    }
    
    /// - Parameters:
    ///   - subscriber
    ///   - handler: block to handle once the subscriber has been deleted
    func deleteSubscriber(_ subscriber: Subscriber, completion handler: @escaping SetSubscriberHandler) {
        firestore.collection(Constants.FirestoreCollections.Subscribers).document(subscriber.id).delete() { error in
            if let error = error {
                handler(.failure(.other(error)))
            } else {
                handler(.success(nil))
            }
        }
    }
}

// MARK: - FirebaseService errors

extension FirebaseService {
    /// - responseError: returned when getting documents from Firestore fails
    /// - invalidDocument: returned when decoding of **QuerySnapshot's document** into **Subscriber** failed
    /// - failedToGetDocuments: returned when **QuerySnapshot's documents** are **nil**
    /// - noDocumentId: returned when adding new subscriber to Firestore doesn't return its id
    /// - other: any other **Error**
    enum FirestoreError: Error {
        case responseError
        case invalidDocument
        case failedToGetDocuments
        case noDocumentId
        case other(Error)
    }
}
