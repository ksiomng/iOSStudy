//
//  MovieCell.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import UIKit
import SnapKit

class MovieCell: UITableViewCell {
    
    let indexLabel = UILabel()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(indexLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
}

extension MovieCell: ViewDesignProtocol {
    func configureLayout() {
        indexLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(indexLabel.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualTo(dateLabel.snp.leading).offset(-8)
        }

        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }

    func configure(index: Int, movie: Movie) {
        indexLabel.text = "\(index + 1)"
        titleLabel.text = movie.title
        dateLabel.text = SongDateFormatter.dateFormat(movie.releaseDate)
    }
    
    func configureView() {
        backgroundColor = .black
        
        indexLabel.textColor = .black
        indexLabel.backgroundColor = .white
        indexLabel.textAlignment = .center
        indexLabel.layer.cornerRadius = 4
        indexLabel.clipsToBounds = true
        indexLabel.font = .boldSystemFont(ofSize: 17)

        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18)

        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textAlignment = .right
    }
}
