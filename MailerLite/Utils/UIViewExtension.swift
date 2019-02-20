//
//  UIViewExtension.swift
//  MailerLite
//
//  Created by Adam Bardon on 20/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

extension UIView {
    func loadNib() {
        guard let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
            else { return }
        Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)
    }
}
