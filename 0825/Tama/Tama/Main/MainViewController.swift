//
//  MainViewController.swift
//  Tama
//
//  Created by Song Kim on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    var tama: Int = 0
    
    private let messageImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bubble")!
        return image
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "복습 아직 안하셨다구요? 지금 잠이 오세요? 대장님??"
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let tamaImage = UIImageView()
    
    private let tamaNameBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.05)
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private lazy var tamaNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.text = UserDefaultsHelper.shared.getTamaData(num: tama).name
        return label
    }()
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let riceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "밥주세요"
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    private let riceLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let riceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("밥먹기", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        button.tintColor = .darkGray
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        return button
    }()
    
    private let waterTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "물주세요"
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    private let waterLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let waterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("물먹기", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        button.tintColor = .darkGray
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        return button
    }()
    
    lazy var viewModel = MainViewModel(tama: tama)
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        bindMessage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupUI()
        bindTama()
    }
    
    private func bindMessage() {
        viewModel.randomMessage()
            .bind(to: messageLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindTama() {
        let riceTap = riceButton.rx.tap
            .withLatestFrom(riceTextField.rx.text.orEmpty)
        
        let waterTap = waterButton.rx.tap
            .withLatestFrom(waterTextField.rx.text.orEmpty)
        
        let input = MainViewModel.Input(riceTap: riceTap, waterTap: waterTap)
        let output = viewModel.transform(input: input)
        
        riceTap
            .bind(with: self) { owner, _ in
                owner.riceTextField.text = ""
            }
            .disposed(by: disposeBag)
        
        waterTap
            .bind(with: self) { owner, _ in
                owner.waterTextField.text = ""
            }
            .disposed(by: disposeBag)
        
        output.message
            .bind(to: messageLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.state
            .bind(to: stateLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.tamaImage
            .bind(to: tamaImage.rx.image)
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "\(UserDefaultsHelper.shared.colonName!)님의 다마고치"
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        button.tintColor = .darkGray
        
        button.rx.tap
            .bind(with: self) { owner, _ in
                owner.settingButtonTapped()
                owner.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func settingButtonTapped() {
        let vc = SettingViewController()
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(messageImage)
        messageImage.addSubview(messageLabel)
        view.addSubview(tamaImage)
        view.addSubview(tamaNameBackground)
        tamaNameBackground.addSubview(tamaNameLabel)
        view.addSubview(stateLabel)
        
        view.addSubview(riceTextField)
        view.addSubview(riceLine)
        view.addSubview(riceButton)
        view.addSubview(waterTextField)
        view.addSubview(waterLine)
        view.addSubview(waterButton)
        
        messageImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.horizontalEdges.equalToSuperview().inset(110)
            make.height.equalTo(120)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16)
            make.centerY.equalTo(messageImage.snp.centerY).offset(-10)
        }
        
        tamaImage.snp.makeConstraints { make in
            make.top.equalTo(messageImage.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(110)
            make.height.equalTo(tamaImage.snp.width)
        }
        
        tamaNameBackground.snp.makeConstraints { make in
            make.top.equalTo(tamaImage.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        tamaNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(tamaNameBackground.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        riceTextField.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(100)
            make.height.equalTo(35)
        }
        
        riceLine.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom).offset(-1)
            make.leading.equalTo(riceTextField)
            make.trailing.equalTo(riceTextField)
            make.height.equalTo(1)
        }
        
        riceButton.snp.makeConstraints { make in
            make.centerY.equalTo(riceTextField)
            make.leading.equalTo(riceTextField.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(100)
            make.height.equalTo(35)
            make.width.equalTo(80)
        }
        
        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(riceLine.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(riceTextField)
            make.height.equalTo(riceTextField)
        }
        
        waterLine.snp.makeConstraints { make in
            make.top.equalTo(waterTextField.snp.bottom).offset(-1)
            make.horizontalEdges.equalTo(waterTextField)
            make.height.equalTo(1)
        }
        
        waterButton.snp.makeConstraints { make in
            make.centerY.equalTo(waterTextField)
            make.horizontalEdges.equalTo(riceButton)
            make.width.height.equalTo(riceButton)
        }
    }
}
