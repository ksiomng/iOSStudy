//
//  SelectProfileViewController.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/13/25.
//

import UIKit

class SelectProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(140)
        }
        
        profileView.setProfileImage(UIImage(named: "3"))

        profileView.cornerRadius()
    }
}
