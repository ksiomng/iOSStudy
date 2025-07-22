//
//  TravelTalkMainViewController.swift
//  0718-Talk
//
//  Created by Song Kim on 7/18/25.
//

import UIKit

class TravelTalkMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var searchBarView: UIView!
    @IBOutlet var chatListCollectionView: UICollectionView!
    @IBOutlet var searchBarTextField: UITextField!
    
    var list = ChatList.list
    let fullList = ChatList.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setCollectionViewLayout()
    }
    
    private func configureView() {
        searchBarView.layer.cornerRadius = 8
        searchBarView.clipsToBounds = true
        
        chatListCollectionView.dataSource = self
        chatListCollectionView.delegate = self
        
        let xib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        chatListCollectionView.register(xib, forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    @IBAction func changedSearchTextField(_ sender: Any) {
        guard let text = searchBarTextField.text?.lowercased(), text != "" else {
            list = fullList
            chatListCollectionView.reloadData()
            return
        }
        filterChatList(text: text)
    }
    
    func filterChatList(text: String) {
        list = fullList.filter { chatRoom in
            chatRoom.chatList.contains { $0.user.name.lowercased().contains(text) }
        }
        chatListCollectionView.reloadData()
    }
}

extension TravelTalkMainViewController {
    private func setCollectionViewLayout() {
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (16 * 2)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        
        chatListCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        let row = list[indexPath.row]
        cell.configureData(row: row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = list[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
        vc.chats = row.chatList
        navigationItem.backBarButtonItem = UI.backNavigation()
        vc.navigationItem.title = row.chatroomName
        navigationController?.pushViewController(vc, animated: true)
    }
}
