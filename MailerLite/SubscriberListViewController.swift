//
//  SubscriberListViewController.swift
//  MailerLite
//
//  Created by Adam Bardon on 18/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit
import IGListKit

/// Main view controller, displays list of subscribers
class SubscriberListViewController: UIViewController {
    private var firebaseServiceFactory: FirebaseServiceFactory?
    private lazy var firebaseService: FirebaseService = {
        if let firebaseServiceFactory = firebaseServiceFactory {
            return firebaseServiceFactory.makeFirebaseService()
        }
        else {
            let firebaseServiceFactory = FirebaseServiceFactory()
            self.firebaseServiceFactory = firebaseServiceFactory
            
            return firebaseServiceFactory.makeFirebaseService()
        }
    }()
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: true, topContentInset: 0, stretchToEdge: false))
        view.backgroundColor = .LightGray
        view.contentInset.top = Constants.Layout.SubscriberList.CollectionTopOffset
        return view
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var subscribers = [Subscriber]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Subscribers"
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .Bunker
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        loadSubscribers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let flowLayout = collectionView.collectionViewLayout as? ListCollectionViewLayout {
            // If we are showing a navigation bar we need to change the y offset for the sticky headers as normal behaviour
            // of the UICollectionView to keep scrolling under the navigation bar. This case the sticky headers to end up below
            // this bar too hence this bit of calculation to determine what the correct y offset is
            flowLayout.stickyHeaderYOffset = self.view.safeAreaLayoutGuide.layoutFrame.size.height + Constants.Layout.SubscriberList.CollectionTopOffset
            collectionView.collectionViewLayout = flowLayout
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    /// - Parameter handler: optional block to handle once the subscribers have been loaded.
    func loadSubscribers(completion handler: (() -> Void)? = nil) {
        firebaseService.getSubscribers(completion: { [weak self] result in
            switch result {
            case .success(let subscribers):
                self?.subscribers = subscribers.sorted(by: { $0.created > $1.created})
                self?.adapter.performUpdates(animated: true)
                
                if let handler = handler {
                    handler()
                }
            case .failure(let error):
                print(error)
                
                if let handler = handler {
                    handler()
                }
            }
        })
    }
    
    @objc func pullToRefresh() {
        collectionView.contentInset.top = Constants.Layout.SubscriberList.CollectionTopOffset + 70
        loadSubscribers(completion: {
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.contentInset.top = Constants.Layout.SubscriberList.CollectionTopOffset
        })
    }
}

// MARK: - SubscriberListSectionDelegate

extension SubscriberListViewController: SubscriberListSectionDelegate {
    func didSelectedSubscriber(_ subscriberListItem: SubscriberListItem) {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                guard let nextController = mainStoryboard.instantiateViewController(withIdentifier: "SubscriberDetailViewController") as? SubscriberDetailViewController else {
                    return
                }
        
                nextController.subscriber = subscriberListItem.subscriber
                self.navigationController?.pushViewController(nextController, animated: true)
    }
}

