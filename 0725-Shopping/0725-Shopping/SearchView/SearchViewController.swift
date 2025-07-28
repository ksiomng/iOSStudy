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
}

class SearchViewController: UIViewController {
    
    var list: [Shop] = []
    var itemName = ""
    var page = 1
    var totalPage = 0
    let maxItemCount = 20
    var sort = SortList.sim
    
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
    
    lazy var simButton: UIButton = {
        let button = SongButton(title: "정확도")
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var dateButton: UIButton = {
        let button = SongButton(title: "날짜순")
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var ascButton: UIButton = {
        let button = SongButton(title: "낮은 가격")
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var dscButton: UIButton = {
        let button = SongButton(title: "높은 가격")
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        return button
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
    
    @objc func sortButtonTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case "정확도":
            if sort == SortList.sim {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                return
            }
            sort = SortList.sim
        case "날짜순":
            if sort == SortList.date {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                return
            }
            sort = SortList.date
        case "낮은 가격":
            if sort == SortList.asc {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                return
            }
            sort = SortList.asc
        case "높은 가격":
            if sort == SortList.dsc {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                return
            }
            sort = SortList.dsc
        case .none: // 비어있을 때
            showAlert(message: "이상한 버튼을 눌렀어요")
            return
        case .some(_): // else 값일 때
            showAlert(message: "이상한 버튼을 눌렀어요")
            return
        }
        updateSortButtonUI(selectedButton: sender)
        list = []
        page = 1
        fetchShopDate(name: itemName, sort: sort.rawValue, page: page)
    }
    
    func fetchShopDate(name: String, sort: String, page: Int) {
        let url = URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(name)&display=\(maxItemCount)&start=\(page)&sort=\(sort)")!
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naverClientId,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300) //
            .responseDecodable(of: Shops.self) { response in
                switch response.result {
                case .success(let res):
                    self.list.append(contentsOf: res.items)
                    self.totalLabel.text = "\(res.total)개의 검색 결과"
                    self.totalPage = res.total
                    self.collectionView.reloadData()
                    
                    if self.page == 1 {
                        DispatchQueue.main.async {
                            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                        }
                    }
                case .failure(let err):
                    print("😒", err)
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
        let buttons = [simButton, dateButton, ascButton, dscButton]
        for button in buttons {
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
        topView.addSubview(simButton)
        topView.addSubview(dateButton)
        topView.addSubview(ascButton)
        topView.addSubview(dscButton)
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
        
        simButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(70)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(4)
            make.leading.equalTo(simButton.snp.trailing).offset(4)
            make.width.equalTo(70)
        }
        
        ascButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(4)
            make.leading.equalTo(dateButton.snp.trailing).offset(4)
            make.width.equalTo(70)
        }
        
        dscButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(4)
            make.leading.equalTo(ascButton.snp.trailing).offset(4)
            make.width.equalTo(70)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        navigationItem.title = itemName
        setCollectionViewLayout()
        fetchShopDate(name: itemName, sort: sort.rawValue, page: page)
        updateSortButtonUI(selectedButton: simButton)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
}
