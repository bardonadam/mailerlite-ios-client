//
//  MLNavigationController.swift
//  MailerLite
//
//  Created by Adam Bardon on 18/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

/// Custom navigation controller with black bar tint and white font color
class MLNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .Bunker
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Appearance.openSansBoldFont(19),
                                             NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.layer.masksToBounds = false
        
        navigationBar.layer.shadowColor = UIColor.Shadow.cgColor
        navigationBar.layer.shadowOpacity = 1
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        navigationBar.layer.shadowRadius = 3
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: Appearance.openSansBoldFont(17)], for: UIControl.State.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
