//
//  UIStackView+Extension.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import UIKit

extension UIStackView {
    func clear() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
