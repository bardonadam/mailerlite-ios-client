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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        background.backgroundColor = .LightGray
        containerView.layer.cornerRadius = 6
        containerView.clipsToBounds = true
        bottomBorderView.backgroundColor = .Platinum
    }
}
