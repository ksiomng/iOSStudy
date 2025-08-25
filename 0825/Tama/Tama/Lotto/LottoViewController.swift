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
    
    let list: BehaviorRelay<[Lotto]> = BehaviorRelay(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        list
            .bind(to: tableView.rx
                .items(cellIdentifier: LottoTableViewCell.identifier, cellType: LottoTableViewCell.self)) { (row, element, cell) in
                    let text = "\(element.drwNoDate)일 "
                    cell.dateLabel.text = text
                    cell.numberLabel.text = "\(element.drwtNo1), \(element.drwtNo2), \(element.drwtNo3), \(element.drwtNo4), \(element.drwtNo5), \(element.drwtNo6)"
                }
                .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in
                LottoObservable.getLotto(query: text)
            }
            .subscribe(with: self) { owner, lotto in
                print("onNext", lotto)
                var data = owner.list.value
                data.insert(lotto, at: 0)
                owner.list.accept(data)
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
