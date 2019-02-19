//
//  FirebaseServiceFactory.swift
//  MailerLite
//
//  Created by Adam Bardon on 18/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import Foundation
import FirebaseFirestore

/// Factory to create and initialize **FirebaseService**
class FirebaseServiceFactory {
    private let firestore: Firestore
    
    init(firestore: Firestore = .firestore()) {
        self.firestore = firestore
        
        let settings = self.firestore.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.firestore.settings = settings
    }
    
    /// - Returns: Initialized FirebaseService
    func makeFirebaseService() -> FirebaseService {
        return FirebaseService(firestore: firestore)
    }
}
