//
//  ChangeNameViewController.swift
//  Tama
//
//  Created by Song Kim on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

class ChangeNameViewController: UIViewController {
    
    let viewModel = ChangeNameViewModel()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = UserDefaultsHelper.shared.colonName!
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "변경할 이름을 입력해주세요"
        return label
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        checkName()
    }
    
    private func checkName() {
        let input = ChangeNameViewModel.Input(name: nameTextField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.stateString
            .bind(to: stateLabel.rx.text)
            .disposed(by: disposeBag)
        
        if let button = navigationItem.rightBarButtonItem?.customView as? UIButton {
            output.isValid
                .bind(to: button.rx.isEnabled)
                .disposed(by: disposeBag)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "이름 정하기"
        let button = UIButton(type: .custom)
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func saveButtonTapped() {
        if let name = nameTextField.text {
            UserDefaultsHelper.shared.colonName = name
        }
        self.nameTextField.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        view.addSubview(nameTextField)
        view.addSubview(lineView)
        view.addSubview(stateLabel)
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(-1)
            make.horizontalEdges.equalTo(nameTextField)
            make.height.equalTo(1)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(2)
            make.horizontalEdges.equalTo(lineView)
        }
    }
}
