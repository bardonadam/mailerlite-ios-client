//
//  Appearance.swift
//  MailerLite
//
//  Created by Adam Bardon on 19/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

struct Appearance {
    // MARK: Fonts
    
    static func openSansLightFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Light", size: size)!
    }
    static func openSansFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans", size: size)!
    }
    static func openSansSemiBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Semibold", size: size)!
    }
    static func openSansBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Bold", size: size)!
    }
    
    static func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
        print("------------------------------")
    }
}
