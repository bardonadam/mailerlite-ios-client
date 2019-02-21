//
//  SubscriberListSectionController.swift
//  MailerLite
//
//  Created by Adam Bardon on 19/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit
import IGListKit

protocol SubscriberListSectionDelegate {
    func didSelectedSubscriber(_ subscriber: SubscriberListItem)
}

// MARK: - SubscriberListSectionController

class SubscriberListSectionController: ListSectionController {
    var subscriberListItem: SubscriberListItem?
    var delegate: SubscriberListSectionDelegate?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: Constants.UI.SubscriberList.ItemHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: "SubscriberListItemCell", bundle: nil, for: self, at: index)
        
        if let cell = cell as? SubscriberListItemCell, let subscriberListItem = subscriberListItem {
            cell.nameLabel.text = subscriberListItem.subscriber.name
            cell.stateView.setup(withState: subscriberListItem.subscriber.state)
            cell.addedLabel.text = Constants.Strings.SubscriberList.Added + subscriberListItem.subscriber.getFormattedDate(dateType: .Created)
            cell.emailLabel.text = subscriberListItem.subscriber.email
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        subscriberListItem = object as? SubscriberListItem
    }
    
    override func didSelectItem(at index: Int) {
        if let subscriberListItem = subscriberListItem {
            delegate?.didSelectedSubscriber(subscriberListItem)
        }
    }
}
