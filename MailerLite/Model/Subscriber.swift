//
//  Subscriber.swift
//  MailerLite
//
//  Created by Adam Bardon on 18/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Subscriber {
    enum State: Int {
        case Active
        case Unsubscribed
    }
    
    let id: String
    let email: String
    let name: String
    let state: State
    let created: Date
    let updated: Date
    
    init(documentSnapshot: QueryDocumentSnapshot) throws {
        guard let email = documentSnapshot.get(Constants.SubscriberModelFields.Email) as? String,
              let name = documentSnapshot.get(Constants.SubscriberModelFields.Name) as? String,
              let stateRaw = documentSnapshot.get(Constants.SubscriberModelFields.State) as? Int,
              let state = State(rawValue: stateRaw),
              let created = documentSnapshot.get(Constants.SubscriberModelFields.Created) as? Timestamp,
              let updated = documentSnapshot.get(Constants.SubscriberModelFields.Updated) as? Timestamp
            else {
            throw FirebaseService.FirestoreError.invalidDocument
        }
        
        self.id = documentSnapshot.documentID
        self.email = email
        self.name = name
        self.state = state
        self.created = created.dateValue()
        self.updated = updated.dateValue()
    }
}
