//
//  SongLabel.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/28/25.
//

import UIKit

class SongLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.numberOfLines = 2
        self.font = .systemFont(ofSize: 10)
        self.text = "브랜드"
        self.textColor = .white
    }
    
    init(title: String, size: CGFloat) {
        super.init(frame: .zero)
        self.numberOfLines = 2
        self.font = .systemFont(ofSize: size)
        self.text = title
        self.textColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
