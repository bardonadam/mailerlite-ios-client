//
//  SubscriberFormViewController.swift
//  MailerLite
//
//  Created by Adam Bardon on 20/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit
import Eureka

protocol SubscriberFormDelegate {
    func didSubmitForm(subscriber: Subscriber)
}

class SubscriberFormViewController: FormViewController {
    enum FormType {
        case NewSubscriber
        case UpdateSubscriber
    }
    
    var subscriber: Subscriber?
    var formType: FormType = .NewSubscriber
    var delegate: SubscriberFormDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var barButtonItems = [UIBarButtonItem]()
        let editBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveBarButtonAction))
        barButtonItems.append(editBarButtonItem)
        
        navigationItem.rightBarButtonItems = barButtonItems
        
        setupForm()
    }
    
    func setupForm() {
        switch formType {
        case .NewSubscriber:
            form +++ Section("Email")
                <<< EmailRow(){ row in
                    row.placeholder = "admiring_ritchie@mailerlite.com"
                    row.add(rule: RuleRequired())
                    row.add(rule: RuleEmail())
                }
                +++ Section("Name")
                <<< NameRow(){ row in
                    row.placeholder = "Admiring Ritchie"
                    row.add(rule: RuleRequired())
                }
        case .UpdateSubscriber:
            form +++ Section("Email")
                <<< EmailRow(){ row in
                    row.value = subscriber?.email
                    row.add(rule: RuleRequired())
                    row.add(rule: RuleEmail())
                }
                +++ Section("Name")
                <<< NameRow(){ row in
                    row.value = subscriber?.name
                    row.add(rule: RuleRequired())
                }
                +++ Section("Subscription State")
                <<< SegmentedRow<Subscriber.State>() { row in
                    row.options = [Subscriber.State.Active, Subscriber.State.Unsubscribed]
                    row.value = subscriber?.state
                }
        }
    }
    
    @objc func saveBarButtonAction() {
        if form.validate().isEmpty {
            if let subscriber = makeSubscriber() {
                delegate?.didSubmitForm(subscriber: subscriber)
                
                navigationController?.popViewController(animated: true)
            }
        }
        else {
            let alert = UIAlertController(title: "Missing or invalid values!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Makes **Subscriber** from current settings
    ///
    /// - Returns: Subscriber
    func makeSubscriber() -> Subscriber? {
        guard let email = form.allRows[0].baseValue as? String,
                let name = form.allRows[1].baseValue as? String
            else {
            return nil
        }
        
        var state: Subscriber.State
        var created: Date?
        var updated: Date?
        
        if formType == .UpdateSubscriber {
            guard let unwrappedState = form.allRows[2].baseValue as? Subscriber.State else {
                return nil
            }
            state = unwrappedState
            created = subscriber?.created
            updated = Date()
        }
        else {
            state = .Active
        }
        
        return Subscriber(email: email, name: name, state: state, created: created, updated: updated)
    }
}
