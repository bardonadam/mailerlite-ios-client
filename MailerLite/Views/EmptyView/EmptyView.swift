//
//  EmptyView.swift
//  MailerLite
//
//  Created by Adam Bardon on 21/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    func load() {
        loadNib()
        addSubview(contentView)
        contentView.frame.size.width = frame.width
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .LightGray
        
        titleLabel.text = Constants.Strings.EmptyView.Title
        subtitleLabel.text = Constants.Strings.EmptyView.Subtitle
        
        titleLabel.textColor = .ShamrockGreen
        subtitleLabel.textColor = .Onyx
    }
}
