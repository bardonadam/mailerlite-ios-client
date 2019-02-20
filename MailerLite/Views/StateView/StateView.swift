//
//  StateView.swift
//  MailerLite
//
//  Created by Adam Bardon on 20/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

class StateView: UIView {
    @IBOutlet var contentView:UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
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
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = self.bounds        
        contentView.layer.cornerRadius = 6
    }
    
    func setup(content: Subscriber.State) {
        switch content {
        case .Active:
            contentView.frame.size.width = Constants.Layout.StateView.Active
            contentView.backgroundColor = .OffGreen
            label.textColor = .Salem
            label.text = Constants.Strings.StateView.Active
        case .Unsubscribed:
            contentView.frame.size.width = Constants.Layout.StateView.Unsubscribed
            contentView.backgroundColor = .EggSour
            label.textColor = .PottersClay
            label.text = Constants.Strings.StateView.Unsubscribed
        }
    }
}
