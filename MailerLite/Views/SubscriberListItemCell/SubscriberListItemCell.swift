//
//  SubscriberListItemCell.swift
//  MailerLite
//
//  Created by Adam Bardon on 19/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

class SubscriberListItemCell: UICollectionViewCell {
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomBorderView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateView: StateView!
    @IBOutlet weak var addedLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        background.backgroundColor = .LightGray
        
        containerView.layer.cornerRadius = 6
        containerView.clipsToBounds = true
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        
        nameLabel.textColor = .Onyx
        
        bottomBorderView.backgroundColor = .Platinum
        
    }
}
