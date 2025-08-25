//
//  SelectTamaCollectionViewCell.swift
//  Tama
//
//  Created by Song Kim on 8/24/25.
//

import UIKit
import SnapKit

class SelectTamaCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tamaNameBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.05)
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private let tamaNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(tamaNameBackground)
        tamaNameBackground.addSubview(tamaNameLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        tamaNameBackground.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        tamaNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }
    
    func configure(image: UIImage, name: String) {
        imageView.image = image
        tamaNameLabel.text = name
    }
}
