//
//  SearchViewController.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/25/25.
//

import UIKit
import SnapKit
import Alamofire

class SearchViewController: UIViewController {

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        fetchShopDate(name: "사과")
    }
    
    func fetchShopDate(name: String) {
        let url = URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(name)")!
        
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
                case .failure(let err):
                    print("😒", err)
                }
            }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension SearchViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
}
