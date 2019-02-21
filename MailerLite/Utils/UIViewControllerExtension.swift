//
//  UIViewControllerExtension.swift
//  MailerLite
//
//  Created by Adam Bardon on 21/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
