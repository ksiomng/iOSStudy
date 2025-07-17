//
//  UILabel+Extension.swift
//  0711
//
//  Created by Song Kim on 7/15/25.
//

import UIKit

extension UILabel {
    func asFontColor(targetStringList: String, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText.lowercased() as NSString).range(of: targetStringList.lowercased())
        attributedString.addAttributes([.foregroundColor: color as Any], range: range)
        attributedText = attributedString
    }
}
