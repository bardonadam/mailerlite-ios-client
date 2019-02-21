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
        let firebaseServiceFactory = FirebaseServiceFactory()
        self.firebaseServiceFactory = firebaseServiceFactory
        
        return firebaseServiceFactory.makeFirebaseService()
    }()
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: true, topContentInset: 0, stretchToEdge: false))
        view.backgroundColor = .LightGray
        view.contentInset.top = Constants.UI.SubscriberList.CollectionTopOffset + Constants.UI.FilterToolbarHeight
        return view
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    lazy var filterViewController = FilterViewController()
    
    var subscribers = [Subscriber]()
    var filterState: FilterState = .All
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Subscribers"
        
        var barButtonItems = [UIBarButtonItem]()
        let addBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBarButtonAction))
        barButtonItems.append(addBarButtonItem)
        
        navigationItem.rightBarButtonItems = barButtonItems
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .Bunker
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        add(filterViewController)
        filterViewController.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let flowLayout = collectionView.collectionViewLayout as? ListCollectionViewLayout {
            // If we are showing a navigation bar we need to change the y offset for the sticky headers as normal behaviour
            // of the UICollectionView to keep scrolling under the navigation bar. This case the sticky headers to end up below
            // this bar too hence this bit of calculation to determine what the correct y offset is
            flowLayout.stickyHeaderYOffset = self.view.safeAreaLayoutGuide.layoutFrame.size.height + Constants.UI.SubscriberList.CollectionTopOffset + filterViewController.getTotalHeight()
            collectionView.collectionViewLayout = flowLayout
        }
        
        loadSubscribers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    @objc func addBarButtonAction() {
        let subscriberFormViewController = SubscriberFormViewController()
        subscriberFormViewController.formType = .NewSubscriber
        subscriberFormViewController.delegate = self
        
        navigationController?.pushViewController(subscriberFormViewController, animated: true)
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
    
    func addSubscriber(subscriber: Subscriber) {
        firebaseService.addSubscriber(subscriber, completion: { [weak self] result in
            switch result {
            case .success:
                self?.loadSubscribers()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    @objc func pullToRefresh() {
        collectionView.contentInset.top = Constants.UI.SubscriberList.CollectionTopOffset + filterViewController.getTotalHeight() + 70
        loadSubscribers(completion: {
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.contentInset.top = Constants.UI.SubscriberList.CollectionTopOffset + self.filterViewController.getTotalHeight()
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
                navigationController?.pushViewController(nextController, animated: true)
    }
}

// MARK: - SubscriberFormDelegate

extension SubscriberListViewController: SubscriberFormDelegate {
    func didSubmitForm(subscriber: Subscriber) {
        addSubscriber(subscriber: subscriber)
    }
}

// MARK: - FilterToolbarProtocol

extension SubscriberListViewController: FilterToolbarProtocol {
    func didChangeFilter(filterState: FilterState) {
        self.filterState = filterState
        adapter.performUpdates(animated: true)
    }
}


