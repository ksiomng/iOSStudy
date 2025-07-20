//
//  TravelTalkMainTableViewCell.swift
//  0718-Talk
//
//  Created by Song Kim on 7/20/25.
//

import UIKit

class TravelTalkMainTableViewCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageContentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        messageContentLabel.font = .systemFont(ofSize: 14)
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .gray
    }
}
