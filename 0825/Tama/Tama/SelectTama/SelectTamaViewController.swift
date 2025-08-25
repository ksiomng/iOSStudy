//
//  SelectTamaViewController.swift
//  Tama
//
//  Created by Song Kim on 8/23/25.
//

import UIKit
import SnapKit

class SelectTamaViewController: UIViewController {
    
    var change: Bool = false
    var tamas: [Tama] = UserDefaultsHelper.shared.checkData()
    
    private lazy var tamaCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let spacing: CGFloat = 24
        let cellCount: CGFloat = 3
        let totalSpacing = spacing * (cellCount + 1)
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / cellCount
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectTamaCollectionViewCell.self, forCellWithReuseIdentifier: SelectTamaCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        self.navigationItem.title = "다마고치 선택하기"
        view.addSubview(tamaCollectionView)
        tamaCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SelectTamaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tamas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelectTamaCollectionViewCell.identifier,
            for: indexPath
        ) as! SelectTamaCollectionViewCell
        
        cell.configure(
            image: UserDefaultsHelper.shared.getTamaImage(num: indexPath.row),
            name: UserDefaultsHelper.shared.tamaNames?[indexPath.row] ?? "?"
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SelectTamaPopUpViewController()
        vc.tama = indexPath.row
        vc.change = change
        vc.configure(num: indexPath.row)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}
