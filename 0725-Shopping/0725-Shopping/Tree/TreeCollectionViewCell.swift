//
//  TreeCollectionViewCell.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/29/25.
//

import UIKit

class TreeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlantCollectionViewCell"
    
    let imageView = UIImageView()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
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

extension TreeCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
    
    func configureDate(row: Shop) {
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
