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
    
    var search = ""
    var list: [Shop] = []
    
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
            let str = SortList.sim.rawValue
            updateSortButtonUI(selectedButton: sender)
            fetchShopDate(name: search, sort: str)
        case "날짜순":
            let str = SortList.date.rawValue
            updateSortButtonUI(selectedButton: sender)
            fetchShopDate(name: search, sort: str)
        case "낮은 가격":
            let str = SortList.asc.rawValue
            updateSortButtonUI(selectedButton: sender)
            fetchShopDate(name: search, sort: str)
        case "높은 가격":
            let str = SortList.dsc.rawValue
            updateSortButtonUI(selectedButton: sender)
            fetchShopDate(name: search, sort: str)
        case .none: // 비어있을 때
            showAlert(message: "이상한 버튼을 눌렀어요")
        case .some(_): // else 값일 때
            showAlert(message: "이상한 버튼을 눌렀어요")
        }
    }
    
    func fetchShopDate(name: String, sort: String) {
        let url = URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(name)&display=20&sort=\(sort)")!
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naverClientId,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300) //
            .responseDecodable(of: Shops.self) { response in
                switch response.result {
                case .success(let res):
                    print(res)
                    self.list = res.items
                    self.totalLabel.text = "\(res.total)개의 검색 결과"
                    self.collectionView.reloadData()
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
        let row = list[indexPath.row]
        if row.brand == "" {
            cell.brandLabel.isHidden = true
        } else {
            cell.brandLabel.isHidden = false
            cell.brandLabel.text = row.brand
        }
        cell.priceLabel.text = row.lprice
        cell.titleLabel.text = row.title.htmlStringChanged
        cell.imageView.kf.setImage(with: URL(string:row.image))
        cell.imageView.clipsToBounds = true
        cell.imageView.layer.cornerRadius = 20
        cell.backgroundColor = .clear
        return cell
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
        
        navigationItem.title = search
        setCollectionViewLayout()
        fetchShopDate(name: search, sort: SortList.sim.rawValue)
        updateSortButtonUI(selectedButton: simButton)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
}
