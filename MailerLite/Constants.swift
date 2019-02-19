//
//  Constants.swift
//  MailerLite
//
//  Created by Adam Bardon on 18/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

struct Constants {
    // MARK: - FirestoreCollections
    struct FirestoreCollections {
        static var Subscribers = "subscribers"
    }
    
    // MARK: - FirestoreCollections
    struct SubscriberModelFields {
        static var Email = "email"
        static var Name = "name"
        static var State = "state"
        static var Created = "created"
        static var Updated = "updated"
    }
    
    struct Layout {
        struct SubscriberList {
            static var CollectionTopOffset: CGFloat = 12
            static var ItemHeight: CGFloat = 120
        }
    }
}
