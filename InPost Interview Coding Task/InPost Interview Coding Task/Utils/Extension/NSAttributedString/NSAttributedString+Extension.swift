//
//  NSAttributedString+Extension.swift
//  InPost Interview Coding Task
//
//

import UIKit

extension NSMutableAttributedString {
    func lineHeight(_ height: CGFloat) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = height
        paragraphStyle.maximumLineHeight = height
        
        addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: string.count))
        
        return self
    }
}
