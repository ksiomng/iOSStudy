//
//  LottoViewController.swift
//  Tama
//
//  Created by Song Kim on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa

struct Lotto: Decodable {
    let drwNoDate: String
    
    let drwtNo6: Int
    let drwtNo5: Int
    let drwtNo4: Int
    let drwtNo3: Int
    let drwtNo2: Int
    let drwtNo1: Int
}

class LottoViewController: UIViewController {
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    let viewModel = LottoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        let input = LottoViewModel.Input(
            searchButton: searchBar.rx.searchButtonClicked,
            query: searchBar.rx.text
        )
        
        let output = viewModel.transform(input: input)
        
        output.lotto
            .bind(to: tableView.rx.items(
                cellIdentifier: LottoTableViewCell.identifier,
                cellType: LottoTableViewCell.self)) { row, element, cell in
                cell.setData(data: element.drwNoDate, num: "\(element.drwtNo1), \(element.drwtNo2), \(element.drwtNo3), \(element.drwtNo4), \(element.drwtNo5), \(element.drwtNo6)")
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
        
        tableView.register(LottoTableViewCell.self, forCellReuseIdentifier: LottoTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
