//
//  SongButton.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import UIKit

class SongButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
