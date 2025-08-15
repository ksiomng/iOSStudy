//
//  MBTIViewController.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/13/25.
//

import UIKit
import SnapKit

class MBTIViewController: UIViewController {
    
    let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "PROFILE SETTING"
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(150)
        }
        
        profileView.setProfileImage(UIImage(named: "3"))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileViewTapped))
        profileView.isUserInteractionEnabled = true
        profileView.addGestureRecognizer(tapGesture)
        
        profileView.cornerRadius()
    }
    
    @objc private func profileViewTapped() {
        let vc = SelectProfileViewController()
        vc.onProfileSelected = { image in
            self.profileView.setProfileImage(image)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
