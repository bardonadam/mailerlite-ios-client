//
//  SubscriberListDataSource.swift
//  MailerLite
//
//  Created by Adam Bardon on 19/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit
import IGListKit

extension SubscriberListViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var listItems = [ListDiffable]()
        
        for subscriber in self.subscribers {
            listItems.append(SubscriberListItem(subscriber: subscriber))
        }
        
        return listItems
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let subscriberListSectionController = SubscriberListSectionController()
        subscriberListSectionController.delegate = self
        
        return subscriberListSectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return UIView()
    }
}
