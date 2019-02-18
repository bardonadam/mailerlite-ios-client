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

class FirebaseService {
    private let firestore: Firestore
    
    init(firestore: Firestore) {
        self.firestore = firestore
    }
    
    typealias SubscribersHandler = (Result<[Subscriber], FirestoreError>) -> Void
    
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

extension FirebaseService {
    enum FirestoreError: Error {
        case responseError
        case invalidDocument
        case failedToGetDocuments
        case unknown
    }
}
