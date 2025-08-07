//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum bmiError: Error {
    case emptyString
    case isNotInt
    case overHeightRange // 10 - 300
    case overWeightRange // 1 - 600
}

class BMIViewController: UIViewController {
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
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
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        guard let height = heightTextField.text, let weight = weightTextField.text else {
            print("TextField가 nil 입니다")
            return
        }
        
        view.endEditing(true)
        do {
            let result = try checkBMIError(height: height, weight: weight)
            print("")
        } catch bmiError.emptyString {
            print("입력된 나이가 없습니다")
        } catch bmiError.isNotInt {
            print("숫자가 아닙니다")
        } catch bmiError.overHeightRange {
            print("키 범위를 벗어났습니다")
        } catch bmiError.overWeightRange {
            print("몸무개 범위를 벗어났습니다")
        } catch {
            print("bmi에러 외의 에러가 발생했습니다")
        }
    }
    
    func checkBMIError<T: StringProtocol>(height: T, weight: T) throws -> Bool {
        guard !(height.isEmpty) && !(weight.isEmpty) else {
            throw bmiError.emptyString
        }
        guard Int(height) != nil && Int(weight) != nil else {
            throw bmiError.isNotInt
        }
        guard 10 < Int(height)! && Int(height)! < 300 else {
            throw bmiError.overHeightRange
        }
        guard 1 < Int(height)! && Int(height)! < 600 else {
            throw bmiError.overWeightRange
        }
        return true
    }
}
