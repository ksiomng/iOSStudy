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
        configureView()
    }
    
    private func configureView() {
        UI.msgRadius(receivedMessageBackgroundView)
        receivedMessageTimeLabel.font = .systemFont(ofSize: 12)
        receivedMessageTimeLabel.textColor = .systemGray
    }
    
    func configureData(row: Chat) {
        receivedMessageContentLabel.text = row.message
        let date = DateFomatter.formatChatTimestamp(row.date, type: "hh:mm a")
        receivedMessageTimeLabel.text = date
    }
}
