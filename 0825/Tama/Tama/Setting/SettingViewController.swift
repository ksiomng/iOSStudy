//
//  SettingViewController.swift
//  Tama
//
//  Created by Song Kim on 8/24/25.
//

import UIKit

class SettingViewController: UIViewController {
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 44
        return tableView
    }()
    
    private var items: [(icon: String, title: String, subtitle: String?)] = [
        ("pencil", "내 이름 설정하기", UserDefaultsHelper.shared.colonName),
        ("moon", "다마고치 변경하기", nil),
        ("arrow.clockwise", "데이터 초기화", nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items[0].subtitle = UserDefaultsHelper.shared.colonName
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        let item = items[indexPath.row]
        cell.configure(icon: item.icon, title: item.title, subtitle: item.subtitle)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationItem.backButtonTitle = "설정"
        navigationController?.navigationBar.tintColor = .darkGray
        
        switch indexPath.row {
        case 0:
            let vc = ChangeNameViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = SelectTamaViewController()
            vc.change = true
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            showAlert(title: "데이터 초기화", msg: "정말 다시 처음부터 시작하실 건가용?") {
                UserDefaultsHelper.shared.colonName = nil
                guard let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate else { return }
                let vc = SelectTamaViewController()
                let nav = UINavigationController(rootViewController: vc)
                sceneDelegate.window?.rootViewController = nav
            }
        default:
            print("이상한 셀을 클릭했어유")
        }
    }
}
