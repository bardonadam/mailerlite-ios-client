//
//  UIColorExtension.swift
//  MailerLite
//
//  Created by Adam Bardon on 18/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

extension UIColor {
    /// Initializes UIColor from hexadecimal string
    ///
    /// - Parameters:
    ///   - hex: e.g. "FFFFFF"
    ///   - alpha: e.g. 0.5, default is 1.0
    public convenience init(hex: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
}

// MARK: - Custom colors

extension UIColor {
    static var Bunker = UIColor(hex: "292C31")
    static var WhiteSmoke = UIColor(hex: "F6F6F6")
    static var Shadow = UIColor(hex: "C9D7E9")
}
