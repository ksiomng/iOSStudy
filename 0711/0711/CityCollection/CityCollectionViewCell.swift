//
//  CityCollectionViewCell.swift
//  0711
//
//  Created by Song Kim on 7/17/25.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CornerRadius.radius(cityImageView, size: (cityImageView.bounds.width+20)/2)
        cityNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        subLabel.font = .systemFont(ofSize: 17)
    }
}
