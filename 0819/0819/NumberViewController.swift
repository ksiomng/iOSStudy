//
//  NumberViewController.swift
//  0819
//
//  Created by Song Kim on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NumberViewController: UIViewController {
    
    let number1TextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.text = "0"
        return textField
    }()
    
    let number2TextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.text = "0"
        return textField
    }()
    
    let number3TextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.text = "0"
        return textField
    }()
    
    let result = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    let plusLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .right
        label.text = "+"
        return label
    }()
    
    let disposeBag = DisposeBag()
    let color = Observable.just(UIColor.lightGray.withAlphaComponent(0.2))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Adding numbers"
        
        view.addSubview(number1TextField)
        view.addSubview(number2TextField)
        view.addSubview(number3TextField)
        view.addSubview(result)
        view.addSubview(plusLabel)
        
        number2TextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        number1TextField.snp.makeConstraints { make in
            make.bottom.equalTo(number2TextField.snp.top).offset(-30)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        number3TextField.snp.makeConstraints { make in
            make.top.equalTo(number2TextField.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        result.snp.makeConstraints { make in
            make.top.equalTo(number3TextField.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        plusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(result)
            make.leading.equalToSuperview().offset(30)
        }
        
        rxUse()
    }
    
    func rxUse() {
        Observable.combineLatest(number1TextField.rx.text.orEmpty, number2TextField.rx.text.orEmpty, number3TextField.rx.text.orEmpty) { text1, text2, text3 -> Int in
                return ((Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0))
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
        
        color
            .bind(to: number1TextField.rx.backgroundColor,
                  number2TextField.rx.backgroundColor,
                  number3TextField.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
}
