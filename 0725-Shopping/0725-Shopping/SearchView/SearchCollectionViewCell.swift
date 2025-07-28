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
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
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
        contentView.addSubview(activityIndicator)
        
        labelStackView.addArrangedSubview(brandLabel)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(priceLabel)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(imageView)
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
    
    func configureDate(row: Shop) {
        if row.brand == "" {
            brandLabel.isHidden = true
        } else {
            brandLabel.isHidden = false
            brandLabel.text = row.brand
        }
        priceLabel.text = PriceFormatter.shared.string(from: Int(row.lprice)! as NSNumber)
        titleLabel.text = row.title.htmlStringChanged
        activityIndicator.startAnimating()

        imageView.kf.setImage(with: URL(string: row.image)) { result in
            switch result {
            case .success(_):
                self.activityIndicator.stopAnimating()
            case .failure(_):
                print("이미지 로딩 실패")
            }
        }
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        backgroundColor = .clear
    }
}
