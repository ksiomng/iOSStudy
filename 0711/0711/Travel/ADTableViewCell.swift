//
//  ADTableViewCell.swift
//  0711
//
//  Created by Song Kim on 7/13/25.
//

import UIKit

class ADTableViewCell: UITableViewCell {

    @IBOutlet var backgroundColorView: UIView!
    @IBOutlet var ADWhiteLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    let randomColor: [UIColor] = [.lightPink, .yellow, .cyan]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColorView.layer.cornerRadius = 10
        ADWhiteLabel.clipsToBounds = true
        ADWhiteLabel.layer.cornerRadius = 15
        contentLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        backgroundColorView.backgroundColor = randomColor.randomElement()
    }
}

