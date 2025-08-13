//
//  SongView.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/14/25.
//

import UIKit

class SongView {
    private init() { }
    static func radius(_ view: UIView, size: CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = size/2
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.songBlue.cgColor
    }
}
