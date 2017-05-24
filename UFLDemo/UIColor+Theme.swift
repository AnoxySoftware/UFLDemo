//
//  UIColor+Theme.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import UIKit

extension UIColor {
    
    ///Convenience initializer with rgb values in 0-255 scale
    convenience init(_ red: Int, _ green : Int, _ blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    ///Convenience initializer with hex values
    convenience init(hex:Int) {
        self.init((hex >> 16) & 0xff, (hex >> 8) & 0xff, hex & 0xff)
    }
    
    @nonobjc static let backgroundColor = UIColor(hex: 0x1BA3EA)
    @nonobjc static let btnSelectedColor = UIColor(hex: 0x14A6D6)
        
}
