//
//  Subscriber.swift
//  MailerLite
//
//  Created by Adam Bardon on 18/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import Foundation
import FirebaseFirestore

/// Subscriber model
///
/// - id: String
/// - email: String
/// - name: String
/// - state: State
/// - created: Date
/// - updated: Date
struct Subscriber {
    
    /// Subscriber's state
    ///
    /// - Active
    /// - Unsubscribed
    enum State: Int {
        case Active
        case Unsubscribed
    }
    
    /// Used as a parameter to get formatted date
    ///
    /// - Created
    /// - Updated
    enum DateType {
        case Created
        case Updated
    }
    
    let id: String
    let email: String
    let name: String
    let state: State
    let created: Date
    let updated: Date
    
    var asDictionary: [String: Any] {
        return ["email": email,
                "name": name,
                "state": state.rawValue,
                "created": created,
                "updated": updated]
    }
    
    /// Initializes Subscriber from FIRQueryDocumentSnapshot
    ///
    /// - Parameter documentSnapshot
    /// - Throws: FirebaseService.FirestoreError.invalidDocument
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
    
    /// Initializes Subscriber from its properties
    init(id: String, email: String, name: String, state: State, created: Date?, updated: Date?) {
        self.id = id
        self.email = email
        self.name = name
        self.state = state
        self.created = created ?? Date()
        self.updated = updated ?? Date()
    }
    
    /// Returns formatted date based on date type
    ///
    /// - Parameter dateType: Created or Updated
    /// - Returns: formatted date, e.g. "Mon 12:43"
    func getFormattedDate(dateType: DateType) -> String {
        if created.isToday {
            return "Today, \(created.time)"
        }
        else if created.isInSameWeek() {
            return created.dayAndTime
        }
        else if created.isInSameYear() {
            return created.monthAndDayAndTime
        }
        else {
            return created.yearAndMonthAndDayAndTime
        }
    }
}
