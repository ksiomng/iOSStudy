//
//  ReceivedMessageTableViewCell.swift
//  0718-Talk
//
//  Created by Song Kim on 7/20/25.
//

import UIKit

class ReceivedMessageTableViewCell: UITableViewCell {
    
    @IBOutlet var receivedMessageContentLabel: UILabel!
    @IBOutlet var receivedMessageBackgroundView: UIView!
    @IBOutlet var receivedMessageTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UI.msgRadius(receivedMessageBackgroundView)
        receivedMessageTimeLabel.font = .systemFont(ofSize: 12)
        receivedMessageTimeLabel.textColor = .systemGray
    }
}
