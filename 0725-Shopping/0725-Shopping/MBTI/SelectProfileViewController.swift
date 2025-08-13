//
//  SelectProfileViewController.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/13/25.
//

import UIKit
import SnapKit

class SelectProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    var onProfileSelected: ((UIImage?) -> Void)?
    
    let profileImages = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let imageWidth = UIScreen.main.bounds.width/4 - 30
        layout.itemSize = CGSize(width: imageWidth, height: imageWidth)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "PROFILE SETTING"
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(140)
            make.height.equalTo(profileView.snp.width)
        }
        profileView.setProfileImage(UIImage(named: profileImages[2]))
        profileView.cornerRadius()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}

extension SelectProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.setImage(UIImage(named: profileImages[indexPath.item]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = UIImage(named: profileImages[indexPath.item])
        profileView.setProfileImage(selectedImage)
        onProfileSelected?(selectedImage)
        if let cell = collectionView.cellForItem(at: indexPath) as? ProfileCell {
            cell.setSelectedStyle(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProfileCell {
            cell.setSelectedStyle(false)
        }
    }
}
