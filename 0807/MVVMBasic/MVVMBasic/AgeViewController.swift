//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum ageError: Error {
    case emptyString
    case isNotInt
    case haveSpace
    case overRange
}

class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        guard let text = textField.text else {
            print("textfield가 nil 입니다")
            return
        }
        view.endEditing(true)
        do {
            let _ = try checkAgeError(text: text)
            print("나이를 잘 입력했습니다")
        } catch ageError.emptyString {
            print("입력된 나이가 없습니다")
        } catch ageError.isNotInt {
            print("숫자가 아닙니다")
        } catch ageError.haveSpace {
            print("공백이 들어가있습니다")
        } catch ageError.overRange {
            print("범위를 벗어났습니다")
        } catch {
            print("ageError외 다른 에러가 발생했습니다")
        }
    }
    
    func checkAgeError(text: String) throws -> Bool {
        guard !(text.isEmpty) else {
            throw ageError.emptyString
        }
        guard Int(text) != nil else {
            throw ageError.isNotInt
        }
        guard text.contains(" ") else {
            throw ageError.haveSpace
        }
        guard 0 < Int(text)! && Int(text)! < 101 else {
            throw ageError.overRange
        }
        return true
    }
}
