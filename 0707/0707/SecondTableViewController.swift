//
//  SecondTableViewController.swift
//  0707
//
//  Created by Song Kim on 7/9/25.
//

import UIKit

struct SetMenu {
    var header: String
    var menu: [String]
}

final class SecondTableViewController: UITableViewController {
    
    private let settings: [SetMenu] = [
        SetMenu(header: "전체설정", menu: ["공지사항", "실험실", "버전정보"]),
        SetMenu(header: "개인설정", menu: ["개인/보안", "알림", "채팅", "멀티 프로필"]),
        SetMenu(header: "기타", menu: ["고객센터/도움말"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "설정"
    }
    
    // MARK: - TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        settings.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settings[section].header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings[section].menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        cell.textLabel?.text = settings[indexPath.section].menu[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
}
