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
        configureView()
    }
    
    private func configureView() {
        UI.msgRadius(sentMessageBackgroundView)
        sentMessageTimeLabel.font = .systemFont(ofSize: 12)
        sentMessageTimeLabel.textColor = .systemGray
        UI.profileRadius(profileImageView)
    }
    
    func configureDate(row: Chat) {
        profileImageView.image = UIImage(named: row.user.image)
        userNameLabel.text = row.user.name
        let date = DateFomatter.formatChatTimestamp(row.date, type: "hh:mm a")
        sentMessageTimeLabel.text = date
        sentMessageContentLabel.text = row.message
    }
}
