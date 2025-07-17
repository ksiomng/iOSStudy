//
//  UILabel+Extension.swift
//  0711
//
//  Created by Song Kim on 7/15/25.
//

import UIKit

extension UILabel {
    func asFontColor(targetStringList: [String], color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        targetStringList.forEach {
            let range = (fullText as NSString).range(of: $0)
            attributedString.addAttributes([.foregroundColor: color as Any], range: range)
        }
        
        attributedText = attributedString
    }
}
