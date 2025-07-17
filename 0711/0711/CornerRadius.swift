//
//  CornerRadius.swift
//  0711
//
//  Created by Song Kim on 7/16/25.
//

import UIKit

class CornerRadius {
    static func radiusTwo(_ view: UIView, size: CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = size
        view.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
    }
    
    static func radiusOne(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner)
    }
    
    static func radius(_ view: UIView, size: CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = size
    }
}
