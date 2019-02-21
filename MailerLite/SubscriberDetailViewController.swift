//
//  SubscriberDetailViewController.swift
//  MailerLite
//
//  Created by Adam Bardon on 20/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

class SubscriberDetailViewController: UIViewController {
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateView: StateView!
    @IBOutlet weak var createdAtTitleLabel: UILabel!
    @IBOutlet weak var createdAtValueLabel: UILabel!
    @IBOutlet weak var updatedAtTitleLabel: UILabel!
    @IBOutlet weak var updatedAtValueLabel: UILabel!
    
    var subscriber: Subscriber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var barButtonItems = [UIBarButtonItem]()
        let editBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editBarButtonAction))
        barButtonItems.append(editBarButtonItem)
        
        navigationItem.rightBarButtonItems = barButtonItems
        
        avaterImageView.layer.masksToBounds = true
        avaterImageView.layer.cornerRadius = avaterImageView.frame.width / 2
        
        emailLabel.text = subscriber?.email
        nameLabel.text = subscriber?.name
        
        if let subscriber = subscriber {
            stateView.setup(withState: subscriber.state, centered: true)
        }
        
        createdAtTitleLabel.textColor = .Steel
        createdAtTitleLabel.text = Constants.Strings.SubscriberDetail.CreatedAt
        createdAtValueLabel.text = subscriber?.created.yearAndMonthAndDayAndTime
        
        updatedAtTitleLabel.textColor = .Steel
        updatedAtTitleLabel.text = Constants.Strings.SubscriberDetail.UpdatedAt
        updatedAtValueLabel.text = subscriber?.updated.yearAndMonthAndDayAndTime
        
    }
    
    @objc func editBarButtonAction() {
        let subscriberFormViewController = SubscriberFormViewController()
        subscriberFormViewController.subscriber = subscriber
        subscriberFormViewController.formType = .UpdateSubscriber
        subscriberFormViewController.delegate = self
        
        navigationController?.pushViewController(subscriberFormViewController, animated: true)
    }
}

// MARK: - SubscriberFormDelegate

extension SubscriberDetailViewController: SubscriberFormDelegate {
    func didSubmitForm(subscriber: Subscriber) {
        self.subscriber = subscriber
        
        emailLabel.text = subscriber.email
        nameLabel.text = subscriber.name
        stateView.setup(withState: subscriber.state, centered: true)
        updatedAtValueLabel.text = subscriber.updated.yearAndMonthAndDayAndTime
    }
}
