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
    @IBOutlet weak var deleteSubscriberButton: UIButton!
    
    private var firebaseServiceFactory: FirebaseServiceFactory?
    private lazy var firebaseService: FirebaseService = {
        let firebaseServiceFactory = FirebaseServiceFactory()
        self.firebaseServiceFactory = firebaseServiceFactory
        
        return firebaseServiceFactory.makeFirebaseService()
    }()
    
    var subscriber: Subscriber?
    
    init(firebaseServiceFactory: FirebaseServiceFactory) {
        self.firebaseServiceFactory = firebaseServiceFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
        
        deleteSubscriberButton.backgroundColor = .CarminePink
        deleteSubscriberButton.setTitle(Constants.Strings.SubscriberDetail.DeleteButtonTitle, for: .normal)
        deleteSubscriberButton.layer.masksToBounds = true
        deleteSubscriberButton.layer.cornerRadius = Constants.UI.CornerRadius

        let emailTap = UITapGestureRecognizer(target: self, action: #selector(emailTapAction))
        emailLabel.isUserInteractionEnabled = true
        emailLabel.addGestureRecognizer(emailTap)
        
        let nameTap = UITapGestureRecognizer(target: self, action: #selector(nameTapAction))
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(nameTap)
    }
    
    // MARK: - UI items actions
    
    @objc func editBarButtonAction() {
        let subscriberFormViewController = SubscriberFormViewController()
        subscriberFormViewController.subscriber = subscriber
        subscriberFormViewController.formType = .UpdateSubscriber
        subscriberFormViewController.delegate = self
        
        navigationController?.pushViewController(subscriberFormViewController, animated: true)
    }

    @objc func emailTapAction() {
        UIPasteboard.general.string = emailLabel.text
    }
    
    @objc func nameTapAction() {
        UIPasteboard.general.string = nameLabel.text
    }
    
    @IBAction func deleteSubscriberButtonAction(_ sender: Any) {
        deleteSubscriber()
    }
    
    // MARK: - Firebase service actions
    
    func updateSubscriber() {
        guard let subscriber = subscriber else {
            return
        }
        
        firebaseService.updateSubscriber(subscriber, completion: { [weak self] result in
            switch result {
            case .success:
                self?.emailLabel.text = subscriber.email
                self?.nameLabel.text = subscriber.name
                self?.stateView.setup(withState: subscriber.state, centered: true)
                self?.updatedAtValueLabel.text = subscriber.updated.yearAndMonthAndDayAndTime
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func deleteSubscriber() {
        guard let subscriber = subscriber else {
            return
        }
        
        firebaseService.deleteSubscriber(subscriber, completion: { [weak self] result in
            switch result {
            case .success:
                self?.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error)
            }
        })
    }
}

// MARK: - SubscriberFormDelegate

extension SubscriberDetailViewController: SubscriberFormDelegate {
    func didSubmitForm(subscriber: Subscriber) {
        self.subscriber = subscriber
        updateSubscriber()
    }
}
