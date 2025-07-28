//
//  SongButton.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/28/25.
//

import UIKit

class SongButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(.systemGray2, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 12)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8
    }
    
    init(title: String) {
        super.init(frame: .zero) // .zero
        self.setTitle(title, for: .normal)
        self.setTitleColor(.systemGray2, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 12)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
