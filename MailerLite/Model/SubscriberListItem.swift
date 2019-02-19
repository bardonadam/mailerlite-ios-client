//
//  SubscriberListItem.swift
//  MailerLite
//
//  Created by Adam Bardon on 19/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import Foundation
import IGListKit

/// Container around **Subscriber** with conformance to **IGListDiffable**
final class SubscriberListItem: NSObject {
    let subscriber: Subscriber
    
    init(subscriber: Subscriber) {
        self.subscriber = subscriber
    }
}

// MARK: - ListDiffable

extension SubscriberListItem: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return subscriber.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? SubscriberListItem else { return false }
        return subscriber.id == object.subscriber.id
    }
}
