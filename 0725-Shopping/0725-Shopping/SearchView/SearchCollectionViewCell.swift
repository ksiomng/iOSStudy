//
//  SearchCollectionViewCell.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/25/25.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    
    let imageView = UIImageView()
    let likeButton = UIButton()
    
    let labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let brandLabel: UILabel = {
        let label = SongLabel(title: "브랜드", size: 10)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = SongLabel(title: "상품명", size: 14)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = SongLabel(title: "가격", size: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(labelStackView)
        
        labelStackView.addArrangedSubview(brandLabel)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(priceLabel)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).inset(10)
            make.trailing.equalTo(imageView.snp.trailing).inset(10)
            make.size.equalTo(28)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
        likeButton.backgroundColor = .white
        likeButton.tintColor = .black
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        DispatchQueue.main.async {
            let buttonWidth = self.likeButton.frame.width
            self.likeButton.layer.cornerRadius = buttonWidth / 2
        }
    }
}
