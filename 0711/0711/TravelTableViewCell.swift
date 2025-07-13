//
//  TravelTableViewCell.swift
//  0711
//
//  Created by Song Kim on 7/13/25.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var fiveStarView: [UIImageView]!
    @IBOutlet var starAndSaveLabel: UILabel!
    @IBOutlet var placeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for star in fiveStarView {
            star.image = UIImage(systemName: "star.fill")
            star.tintColor = .systemGray
        }
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        descriptionLabel.textColor = .systemGray
        starAndSaveLabel.font = UIFont.systemFont(ofSize: 14)
        starAndSaveLabel.textColor = .systemGray4
        placeImageView.layer.cornerRadius = 10
    }
}

