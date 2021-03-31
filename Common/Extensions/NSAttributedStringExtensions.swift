//
//  NSAttributedStringExtensions.swift
//  Deezer
//
//  Created by Laurent Droguet on 18/03/2020.
//  Copyright © 2020 Deezer SA. All rights reserved.
//

import UIKit

// MARK: Properties
public extension NSAttributedString {
    static var bulletPoint: NSAttributedString {
        NSAttributedString(string: "\u{2022}")
    }
    
    static var space: NSAttributedString {
        NSAttributedString(string: " ")
    }
    
    var bold: NSAttributedString {
        return applying(attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    var centered: NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return applying(attributes: [.paragraphStyle: style])
    }
}
// MARK: Methods
extension NSAttributedString {
    func colored(with color: UIColor) -> NSAttributedString {
        return applying(attributes: [.foregroundColor: color])
    }
    
    func applying(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        let range = (string as NSString).range(of: string)
        copy.addAttributes(attributes, range: range)
        return copy
    }
}
// MARK: Operators
extension NSAttributedString {
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }
}
