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
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (16 * 2) - (16 * 3)) / 2
        CornerRadius.radius(cityImageView, size: (cellWidth/2))
        cityNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        subLabel.font = .systemFont(ofSize: 13)
        subLabel.textColor = .gray
    }
}
