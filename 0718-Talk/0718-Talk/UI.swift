//
//  UI.swift
//  0718-Talk
//
//  Created by Song Kim on 7/20/25.
//

import UIKit

class UI {
    static func msgRadius(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    static func profileRadius(_ view: UIView) {
        DispatchQueue.main.async {
            let size = view.frame.width / 2
            view.clipsToBounds = true
            view.layer.cornerRadius = size
        }
    }
}
