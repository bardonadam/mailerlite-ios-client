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
    
    // MARK: - SubscriberModelFields
    
    struct SubscriberModelFields {
        static var Email = "email"
        static var Name = "name"
        static var State = "state"
        static var Created = "created"
        static var Updated = "updated"
    }
    
    // MARK: - Layout
    
    struct Layout {
        struct SubscriberList {
            static var CollectionTopOffset: CGFloat = 12
            static var ItemHeight: CGFloat = 132
        }
        
        struct StateView {
            static var Active: CGFloat = 60
            static var Unsubscribed: CGFloat = 114
        }
    }
    
    // MARK: - Strings
    
    struct Strings {
        struct SubscriberList {
            static var Added = "Added: "
        }
        
        struct SubscriberDetail {
            static var CreatedAt = "Created at:"
            static var UpdatedAt = "Updated at:"
        }
        
        struct StateView {
            static var Active = "Active"
            static var Unsubscribed = "Unsubscribed"
        }
    }
}
