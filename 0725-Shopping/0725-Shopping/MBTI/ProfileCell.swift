//
//  ProfileCell.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/14/25.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.layer.cornerRadius = frame.width / 2
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        imageView.alpha = 0.6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    func setSelectedStyle(_ selected: Bool) {
        contentView.layer.borderColor = selected ? UIColor.systemBlue.cgColor : UIColor.gray.cgColor
        contentView.layer.borderWidth = selected ? 3 : 1
        imageView.alpha = selected ? 1.0 : 0.6
    }
}

