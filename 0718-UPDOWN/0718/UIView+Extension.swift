//
//  UIView+Extension.swift
//  0718
//
//  Created by Song Kim on 7/18/25.
//

import UIKit

extension UIView {
    func radius(size: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = size
    }
}
