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
        topNPayLabel.backgroundColor = .yellow
        topNPayLabel.snp.makeConstraints { make in
            make.top.equalTo(whiteCardView).offset(10)
            make.leading.equalTo(whiteCardView).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        cancelButton.backgroundColor = .blue
        whiteCardView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(whiteCardView).offset(10)
            make.trailing.equalTo(whiteCardView).inset(10)
            make.width.height.equalTo(50)
        }
        
        messageLabel.backgroundColor = .cyan
        whiteCardView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(whiteCardView).inset(10)
            make.top.equalTo(topNPayLabel.snp.bottom).offset(50)
            make.height.equalTo(150)
        }
        
        checkedButton.backgroundColor = .red
        whiteCardView.addSubview(checkedButton)
        checkedButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(50)
            make.leading.equalTo(whiteCardView).offset(80)
            make.width.height.equalTo(30)
        }
        
        checkedButtonLabel.backgroundColor = .red
        whiteCardView.addSubview(checkedButtonLabel)
        checkedButtonLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkedButton)
            make.leading.equalTo(checkedButton.snp.trailing).offset(20)
            make.trailing.equalTo(whiteCardView).offset(-80)
            make.height.equalTo(30)
        }
        
        resultButton.backgroundColor = .gray
        whiteCardView.addSubview(resultButton)
        resultButton.snp.makeConstraints { make in
            make.bottom.equalTo(whiteCardView).offset(-15)
            make.leading.trailing.equalTo(whiteCardView).inset(30)
            make.height.equalTo(50)
        }
        resultButton.layer.cornerRadius = 15
    }


}

