//
//  UserTableViewCell.swift
//  iOSAcademy-RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import SnapKit

final class MovieTableViewCell: UITableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
      
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    private func configure() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(numberLabel)
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
        }
        
        numberLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

