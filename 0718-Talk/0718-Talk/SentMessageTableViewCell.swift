//
//  SentMessageTableViewCell.swift
//  0718-Talk
//
//  Created by Song Kim on 7/20/25.
//

import UIKit

class SentMessageTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var sentMessageContentLabel: UILabel!
    @IBOutlet var sentMessageTimeLabel: UILabel!
    @IBOutlet var sentMessageBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UI.msgRadius(sentMessageBackgroundView)
    }
}
