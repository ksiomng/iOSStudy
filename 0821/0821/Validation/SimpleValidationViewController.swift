//
//  SimpleValidationViewController.swift
//  0819
//
//  Created by Song Kim on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let usernameStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let doSomethingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Do Something", for: .normal)
        button.backgroundColor = .green
        button.isEnabled = false
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Simple validation"
        
        view.addSubview(usernameTextField)
        view.addSubview(usernameStateLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordStateLabel)
        view.addSubview(doSomethingButton)
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        usernameStateLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(8)
            make.leading.equalTo(usernameTextField)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameStateLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        passwordStateLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalTo(passwordTextField)
        }
        
        doSomethingButton.snp.makeConstraints { make in
            make.top.equalTo(passwordStateLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
    
    private func bind() {
        usernameStateLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordStateLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .map { $0 }
            .bind(to: usernameStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showAlert()
            })
            .disposed(by: disposeBag)
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
