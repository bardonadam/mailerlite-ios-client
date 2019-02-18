//
//  Constants.swift
//  MailerLite
//
//  Created by Adam Bardon on 18/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import Foundation

struct Constants {
    struct FirestoreCollections {
        static var Subscribers = "subscribers"
    }
    
    struct SubscriberModelFields {
        static var Email = "email"
        static var Name = "name"
        static var State = "state"
        static var Created = "created"
        static var Updated = "updated"
    }
}
