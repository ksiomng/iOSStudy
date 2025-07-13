//
//  TravelTableViewCell.swift
//  0711
//
//  Created by Song Kim on 7/13/25.
//

import UIKit
import Kingfisher

class MagazineTableViewCell: UITableViewCell {
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleImageView.layer.cornerRadius = 10
    }
}
