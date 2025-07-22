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
    }
    
    private func configureTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        
        let xib = UINib(nibName: "ReceivedMessageTableViewCell", bundle: nil)
        chatTableView.register(xib, forCellReuseIdentifier: "ReceivedMessageTableViewCell")
        let xib2 = UINib(nibName: "SentMessageTableViewCell", bundle: nil)
        chatTableView.register(xib2, forCellReuseIdentifier: "SentMessageTableViewCell")
        
        scrollToBottom()
    }
    
    func scrollToBottom() {
        let lastRow = chatTableView.numberOfRows(inSection: 0) - 1
        if lastRow >= 0 {
            let indexPath = IndexPath(row: lastRow, section: 0)
            DispatchQueue.main.async {
                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
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
        scrollToBottom()
    }
}

extension MessageViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = chats[indexPath.row]
        
        if row.user.name == "김새싹" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedMessageTableViewCell", for: indexPath) as! ReceivedMessageTableViewCell
            cell.configureData(row: row)
            
            if indexPath.row > 0 {
                let nowDate = DateFomatter.formatChatTimestamp(row.date, type: "YYMMDD")
                let beforeDate = DateFomatter.formatChatTimestamp(chats[indexPath.row - 1].date, type: "YYMMDD")
                if nowDate != beforeDate  {
                    print(nowDate, beforeDate)
                    cell.dividerView.isHidden = false
                } else {
                    cell.dividerView.isHidden = true
                }
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SentMessageTableViewCell", for: indexPath) as! SentMessageTableViewCell
            cell.configureDate(row: row)
            
            if indexPath.row > 0 {
                if row.date == chats[indexPath.row - 1].date {
                    cell.userNameLabel.isHidden = true
                    cell.profileImageView.isHidden = true
                } else {
                    cell.userNameLabel.isHidden = false
                    cell.profileImageView.isHidden = false
                    let nowDate = DateFomatter.formatChatTimestamp(row.date, type: "YYMMDD")
                    let beforeDate = DateFomatter.formatChatTimestamp(chats[indexPath.row - 1].date, type: "YYMMDD")
                    if nowDate != beforeDate  {
                        print(nowDate, beforeDate)
                        cell.dividerView.isHidden = false
                    } else {
                        cell.dividerView.isHidden = true
                    }
                }
            }
            
            return cell
        }
    }
    
    func checkDivider(cell: UITableViewCell) {
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
