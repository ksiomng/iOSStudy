//
//  SearchViewController.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/25/25.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

enum SortList: String, CaseIterable {
    case sim = "sim"   // 정확도순
    case date = "date" // 날짜순
    case asc = "asc"   // 낮은 가격순
    case dsc = "dsc"   // 높은 가격순
    
    var displayName: String {
        switch self {
        case .sim: return "정확도순"
        case .date: return "날짜순"
        case .asc: return "낮은 가격순"
        case .dsc: return "높은 가격순"
        }
    }
}

class SearchViewController: UIViewController {
    
    var list: [Shop] = []
    var itemName = ""
    var page = 1
    var totalPage = 0
    let maxItemCount = 30
    var sort = SortList.sim
    private var sortButtons: [UIButton] = []
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fillEqually
        return stack
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func makeSortButtons() {
        SortList.allCases.forEach { option in
            let button = SongButton(title: option.displayName)
            button.tag = sortButtons.count
            button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
            buttonStackView.addArrangedSubview(button)
            sortButtons.append(button)
        }
    }
    
    @objc func sortButtonTapped(_ sender: UIButton) {
        guard let index = sortButtons.firstIndex(of: sender) else { return }
        
        if sort == SortList.allCases[index] {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            return
        }
        
        sort = SortList.allCases[index]
        updateSortButtonUI(selectedButton: sender)
        
        list.removeAll()
        page = 1
        fetchShopDate(name: itemName, sort: sort.rawValue, page: page)
    }
    
    func fetchShopDate(name: String, sort: String, page: Int) {
        let start = (page-1) * maxItemCount + 1
        NetworkManager.shared.fetchShopDate(name: name, sort: sort, page: start, itemCount: maxItemCount) { res in
            self.list.append(contentsOf: res.items)
            self.totalLabel.text = "\(res.total)개의 검색 결과"
            self.totalPage = res.total
            self.collectionView.reloadData()
            
            if self.list.count == 0 {
                self.showErrorAlert(message: "검색결과가 없습니다") {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            if self.page == 1 {
                DispatchQueue.main.async {
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                }
            }
        } fail: { err in
            if start > 1000 {
                self.showAlert(message: "마지막페이지입니다")
            } else {
                let errMsg = ErrorString.shared.result(errCode: err ?? 0)
                self.showErrorAlert(title: "ERROR", message: errMsg) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func setCollectionViewLayout() {
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (16 * 2) - 16) / 2
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
    private func updateSortButtonUI(selectedButton: UIButton) {
        for button in sortButtons {
            if button == selectedButton {
                button.backgroundColor = .white
                button.setTitleColor(.black, for: .normal)
            } else {
                button.backgroundColor = .clear
                button.setTitleColor(.systemGray2, for: .normal)
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureDate(row: list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastPage =  totalPage / maxItemCount == 0 ? (totalPage / maxItemCount) : (totalPage / maxItemCount) + 1
        if indexPath.row == (list.count - 6) && page < lastPage {
            page += 1
            fetchShopDate(name: itemName, sort: sort.rawValue, page: page)
            
        }
    }
}

extension SearchViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(topView)
        view.addSubview(collectionView)
        
        topView.addSubview(totalLabel)
        topView.addSubview(buttonStackView)
        
        makeSortButtons()
    }
    
    func configureLayout() {
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(55)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(4)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        navigationItem.title = itemName
        setCollectionViewLayout()
        fetchShopDate(name: itemName, sort: sort.rawValue, page: page)
        updateSortButtonUI(selectedButton: sortButtons[0])
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
}
