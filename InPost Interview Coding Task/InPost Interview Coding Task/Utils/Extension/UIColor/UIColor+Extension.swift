//
//  UIColor+Extension.swift
//  InPost Interview Coding Task
//
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let red = CGFloat((hex >> 16) & 0xff) / 255
        let green = CGFloat((hex >> 08) & 0xff) / 255
        let blue = CGFloat((hex >> 00) & 0xff) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static let grayDark = UIColor(hex: 0x404041)
    static let grayLight = UIColor(hex: 0x929497)
    static let brandYellow = UIColor(hex: 0xFFCD00)
}
