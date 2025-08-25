//
//  BoxViewController.swift
//  Tama
//
//  Created by Song Kim on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa

class BoxViewController: UIViewController {
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    let viewModel = BoxViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        let input = BoxViewModel.Input(
            searchButton: searchBar.rx.searchButtonClicked,
            query: searchBar.rx.text
        )
        
        let output = viewModel.transform(input: input)
        
        output.movies
            .bind(to: tableView.rx.items(
                cellIdentifier: MovieTableViewCell.identifier,
                cellType: MovieTableViewCell.self
            )) { row, element, cell in
                cell.setData(data: element.openDt, num: element.movieNm)
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
