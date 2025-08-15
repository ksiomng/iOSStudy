//
//  ProfileView.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/14/25.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
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
        addSubview(profileImageView)
        addSubview(cameraView)
        cameraView.addSubview(cameraImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(profileImageView.snp.width)
        }
        
        cameraView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView).offset(-5)
            make.width.height.equalTo(profileImageView.snp.width).multipliedBy(0.3)
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
            SongView.radius(self.profileImageView, size: self.profileImageView.frame.width)
            SongView.radius(self.cameraView, size: self.cameraView.frame.width)
        }
    }
}
