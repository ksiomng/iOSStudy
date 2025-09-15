//
//  ViewController.swift
//  Wishlist
//
//  Created by Song Kim on 9/15/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var list = ["과자", "고양이 장난감"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureCellRegistration()
        updateSnapshot()
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<String, String>!
    private var registration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .clear
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureCellRegistration() {
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.color = .white
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listCell()
            background.backgroundColor = .gray
            cell.backgroundConfiguration = background
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.registration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            return cell
        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["0"])
        snapshot.appendItems(list, toSection: "0")
        dataSource.apply(snapshot)
    }
}

extension ViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        searchBar.delegate = self
        
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        list.append(text)
        updateSnapshot()
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
