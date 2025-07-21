//
//  ViewController.swift
//  0721-SnapKit
//
//  Created by Song Kim on 7/21/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let whiteCardView = UIView()
    let topNPayLabel = UILabel()
    let cancelButton = UIButton()
    let messageLabel = UILabel()
    let checkedButton = UIButton()
    let checkedButtonLabel = UILabel()
    let resultButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(whiteCardView)
        whiteCardView.backgroundColor = .white
        whiteCardView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets).offset(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(450)
        }
        whiteCardView.layer.cornerRadius = 15
        
        whiteCardView.addSubview(topNPayLabel)
        topNPayLabel.snp.makeConstraints { make in
            make.top.equalTo(whiteCardView).offset(10)
            make.leading.equalTo(whiteCardView).offset(10)
            make.width.equalTo(100)
        }
        topNPayLabel.text = "NPAY국내"
    }


}

