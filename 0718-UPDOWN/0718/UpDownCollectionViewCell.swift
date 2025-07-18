//
//  UpDownCollectionViewCell.swift
//  0718
//
//  Created by Song Kim on 7/17/25.
//

import UIKit

class UpDownCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (16 * 2) - (8 * 5)) / 6
        radius(numberLabel, size: cellWidth/2)
    }
    
    func radius(_ view: UIView, size: CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = size
    }
}
