//
//  MainViewController.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/25/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let viewModel = MainViewModel()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "브랜드, 상품, 프로필, 태그 등",
            attributes: [
                .foregroundColor: UIColor.lightGray
            ]
        )
        searchBar.delegate = self
        return searchBar
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemTeal
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        viewModel.outputPossibleSearchString.bind { msg in
            self.statusLabel.text = msg
        }
    }
}

extension MainViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(statusLabel)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(2)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configureView() {
        configureNavigation()
        navigationItem.title = "영캠러의 쇼핑쇼핑"
        view.backgroundColor = .black
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .white
        navigationItem.backBarButtonItem = backButton
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if viewModel.outputPossibleSearch.value {
            let vc = SearchViewController()
            vc.itemName = viewModel.inputSearchWord.value!
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputSearchWord.value = searchBar.text
    }
}
