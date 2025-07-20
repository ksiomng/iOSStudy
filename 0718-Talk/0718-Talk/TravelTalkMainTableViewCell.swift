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
        configureView()
    }
    
    private func configureView() {
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        messageContentLabel.font = .systemFont(ofSize: 14)
        messageContentLabel.textColor = .darkGray
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .gray
    }
    
    func configureData(row: ChatRoom) {
        profileImage.image = UIImage(named: row.chatroomImage)
        UI.profileRadius(profileImage)
        nameLabel.text = row.chatroomName
        let date = DateFomatter.formatChatTimestamp(row.chatList.last!.date, type: "yy.MM.dd")
        dateLabel.text = date
        messageContentLabel.text = row.chatList.last?.message
    }
}
