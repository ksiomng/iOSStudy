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
    
    let list: BehaviorRelay<[BoxOffice]> = BehaviorRelay(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        list
            .bind(to: tableView.rx
                .items(cellIdentifier: MovieTableViewCell.identifier, cellType: MovieTableViewCell.self)) { (row, element, cell) in
                    let text = "\(element.openDt)일 "
                    cell.dateLabel.text = text
                    cell.numberLabel.text = element.movieNm
                }
                .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in
                MovieObservable.getMoive(date: text)
            }
            .subscribe(with: self) { owner, movies in
                print("onNext", movies)
                owner.list.accept(movies)
            } onError: { owner, err in
                print("onError", err)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
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
