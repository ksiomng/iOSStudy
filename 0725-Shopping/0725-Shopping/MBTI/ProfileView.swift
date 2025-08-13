//
//  ProfileView.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/14/25.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    private let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .songBlue
        return view
    }()
    
    private let cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileView)
        addSubview(cameraView)
        cameraView.addSubview(cameraImageView)
        profileView.addSubview(profileImageView)
        
        profileView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(profileView.snp.width)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
        cameraView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileView).offset(-5)
            make.width.height.equalTo(30)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }
    
    func setProfileImage(_ image: UIImage?) {
        profileImageView.image = image
    }
    
    func cornerRadius() {
        DispatchQueue.main.async {
            SongView.radius(self.profileView, size: self.profileView.frame.width)
            SongView.radius(self.cameraView, size: self.cameraView.frame.width)
        }
    }
}
