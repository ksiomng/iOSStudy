//
//  SelectTamaPopUpViewController.swift
//  Tama
//
//  Created by Song Kim on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift

class SelectTamaPopUpViewController: UIViewController {
    
    var change: Bool = false
    var tama = 0
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tamaNameBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.05)
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private let tamaNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.6)
        return view
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "저는 방실방실 다마고치 입니당 키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        return button
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(change ? "변경하기" : "시작하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        setupUI()
        buttonSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if tamaNameLabel.text == "준비중이에요" {
            startButton.isEnabled = false
            startButton.setTitleColor(.gray, for: .normal)
        } else {
            startButton.isEnabled = true
            startButton.setTitleColor(.blue, for: .normal)
        }
    }
    
    private func buttonSet() {
        cancelButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        startButton.rx.tap
            .bind(with: self) { owner, _ in
                guard let sceneDelegate = owner.view.window?.windowScene?.delegate as? SceneDelegate else { return }
                let vc = MainViewController()
                vc.tama = self.tama
                let nav = UINavigationController(rootViewController: vc)
                sceneDelegate.window?.rootViewController = nav
            }
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(tamaNameBackground)
        tamaNameBackground.addSubview(tamaNameLabel)
        containerView.addSubview(lineView)
        containerView.addSubview(contentLabel)
        containerView.addSubview(cancelButton)
        containerView.addSubview(startButton)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(32)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(160)
        }
        
        tamaNameBackground.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.greaterThanOrEqualTo(120)
        }
        
        tamaNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(tamaNameBackground.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(44)
            make.height.equalTo(1)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(44)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(24)
            make.leading.bottom.equalToSuperview()
            make.height.equalTo(50)
            make.trailing.equalTo(containerView.snp.centerX)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(24)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(50)
            make.leading.equalTo(containerView.snp.centerX)
        }
    }
    
    func configure(num: Int) {
        self.imageView.image = UserDefaultsHelper.shared.getTamaImage(num: num)
        self.tamaNameLabel.text = UserDefaultsHelper.shared.tamaNames![num]
    }
}
