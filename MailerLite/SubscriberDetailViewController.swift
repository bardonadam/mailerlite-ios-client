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
}