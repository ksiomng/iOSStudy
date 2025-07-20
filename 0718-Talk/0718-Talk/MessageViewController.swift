//
//  MessageViewController.swift
//  0718-Talk
//
//  Created by Song Kim on 7/20/25.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var sentMessageTextField: UITextField!
    
    var chats = [Chat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
    }
    
    private func configureTableView() {
        let xib = UINib(nibName: "ReceivedMessageTableViewCell", bundle: nil)
        chatTableView.register(xib, forCellReuseIdentifier: "ReceivedMessageTableViewCell")
        let xib2 = UINib(nibName: "SentMessageTableViewCell", bundle: nil)
        chatTableView.register(xib2, forCellReuseIdentifier: "SentMessageTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = chats[indexPath.row]
        let date = DateFomatter.formatChatTimestamp(row.date, type: "hh:mm a")
        
        if row.user.name == "김새싹" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedMessageTableViewCell", for: indexPath) as! ReceivedMessageTableViewCell
            cell.receivedMessageContentLabel.text = row.message
            
            cell.receivedMessageTimeLabel.text = date
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SentMessageTableViewCell", for: indexPath) as! SentMessageTableViewCell
            cell.profileImageView.image = UIImage(named: row.user.image)
            cell.userNameLabel.text = row.user.name
            cell.sentMessageTimeLabel.text = date
            cell.sentMessageContentLabel.text = row.message
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    @IBAction func enterSentMessage(_ sender: Any) {
        appendMessage()
    }
    
    @IBAction func sentButtonClicked(_ sender: UIButton) {
        appendMessage()
        view.endEditing(true)
    }
    
    func appendMessage() {
        if let text = sentMessageTextField.text {
            chats.append(Chat(user: ChatList.me, date: DateFomatter.nowDateString(), message: text))
            chatTableView.reloadData()
        }
        sentMessageTextField.text = ""
    }
    
}
