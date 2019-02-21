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
    
    struct UI {
        struct SubscriberList {
            static var CollectionTopOffset: CGFloat = 12
            static var ItemHeight: CGFloat = 132
        }
        
        struct StateView {
            static var Active: CGFloat = 60
            static var Unsubscribed: CGFloat = 114
        }
        
        static var CornerRadius: CGFloat = 6
        static var FilterToolbarHeight: CGFloat = 50
    }
    
    // MARK: - Strings
    
    struct Strings {
        struct SubscriberList {
            static var Added = "Added: "
        }
        
        struct SubscriberDetail {
            static var CreatedAt = "Created at:"
            static var UpdatedAt = "Updated at:"
            static var DeleteButtonTitle = "Delete Subscriber"
        }
        
        struct State {
            static var Active = "Active"
            static var Unsubscribed = "Unsubscribed"
        }
        
        struct EmptyView {
            static var Title = "No Subscribers Yet"
            static var Subtitle = "It looks a little empty in here!"
        }
        
        struct Filter {
            static var Subscriber = "Subscriber"
            static var Subscribers = "Subscribers"
            static var Title = "Show \(Subscribers):"
        }
    }
}
