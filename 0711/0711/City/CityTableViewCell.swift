//
//  CityTableViewCell.swift
//  0711
//
//  Created by Song Kim on 7/15/25.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    static let identifier = "CityTableViewCell"

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var cityListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        cityListLabel.textColor = .white
        cityListLabel.backgroundColor = UIColor(white: 0, alpha: 0.5) // 검은색 0.5퍼 튜명도
        cityListLabel.font = .systemFont(ofSize: 15)
        radiusTwo(backgroundImageView)
        radiusOne(cityListLabel)
    }
    
    func radiusTwo(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
    }
    
    func radiusOne(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
