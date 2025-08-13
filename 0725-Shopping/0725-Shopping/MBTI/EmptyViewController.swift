//
//  EmptyViewController.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/14/25.
//

import UIKit
import SnapKit

class EmptyViewController: UIViewController {
    
    lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("설정화면으로", for: .normal)
        button.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
    }
    
    @objc private func settingButtonTapped() {
        let vc = MBTIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
