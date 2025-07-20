//
//  TravelTalkMainViewController.swift
//  0718-Talk
//
//  Created by Song Kim on 7/18/25.
//

import UIKit

class TravelTalkMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var searchBarView: UIView!
    @IBOutlet var chatListTabelView: UITableView!
    @IBOutlet var searchBarTextField: UITextField!
    
    var list = ChatList.list
    let fullList = ChatList.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        searchBarView.layer.cornerRadius = 8
        searchBarView.clipsToBounds = true
        
        chatListTabelView.dataSource = self
        chatListTabelView.delegate = self
        chatListTabelView.separatorStyle = .none
        
        let xib = UINib(nibName: "TravelTalkMainTableViewCell", bundle: nil)
        chatListTabelView.register(xib, forCellReuseIdentifier: "TravelTalkMainTableViewCell")
    }
    
    @IBAction func changedSearchTextField(_ sender: Any) {
        guard let text = searchBarTextField.text?.lowercased(), text != "" else {
            list = fullList
            chatListTabelView.reloadData()
            return
        }
        filterChatList(text: text)
    }
    
    func filterChatList(text: String) {
        list = fullList.filter { chatRoom in
            chatRoom.chatList.contains { $0.user.name.lowercased().contains(text) }
        }
        chatListTabelView.reloadData()
    }
}

extension TravelTalkMainViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelTalkMainTableViewCell", for: indexPath) as! TravelTalkMainTableViewCell
        let row = list[indexPath.row]
        cell.configureData(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = list[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
        vc.chats = row.chatList
        navigationItem.backBarButtonItem = UI.backNavigation()
        vc.navigationItem.title = row.chatroomName
        navigationController?.pushViewController(vc, animated: true)
    }
}
