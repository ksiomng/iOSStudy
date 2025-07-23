//
//  LottoViewController.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {
    
    let episodeTextField = UITextField()
    let lottoInfoLabel = UILabel()
    let dateLabel = UILabel()
    let episodeTitleLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemOrange
        return label
    }()
    let numberStackView = UIStackView()
    let bonusLabel = UILabel()
    let bonusBall = UILabel()
    
    let pickerView = UIPickerView()
    let episode = Array(1...1181)
    
    var selectedEpisode = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureView()
    }

    func generateLottoNumbers() -> [Int] {
        let numbers = Array(1...45).shuffled()
        let randomNum = Array(numbers.prefix(7)).sorted()
        return randomNum
    }
    
    func updateLottoNumbers() {
        let numbers = generateLottoNumbers()
        numberStackView.clear()
        
        for i in 0..<6 {
            let ball = createBallLabel(number: numbers[i])
            numberStackView.addArrangedSubview(ball)
        }
        
        numberStackView.addArrangedSubview(bonusLabel)
        bonusBall.text = "\(numbers.last!)"
        numberStackView.addArrangedSubview(bonusBall)
        
        episodeTitleLabel.text = "\(selectedEpisode)회 당첨결과"
    }
    
    func createBallLabel(number: Int) -> UILabel {
        let label = UILabel()
        label.text = "\(number)"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.backgroundColor = selectColor(number)
        label.layer.masksToBounds = true
        label.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        label.layer.cornerRadius = 20
        return label
    }
    
    func selectColor(_ number: Int) -> UIColor {
        switch number {
        case 1...10:
            return .red
        case 11...20:
            return .orange
        case 21...30:
            return .green
        case 31...40:
            return .blue
        case 41...45:
            return .purple
        default:
            return .gray
        }

    }
}

extension LottoViewController: ViewDesignProtocol {
    
    func configureHierarchy() {
        view.addSubview(episodeTextField)
        view.addSubview(lottoInfoLabel)
        view.addSubview(dateLabel)
        view.addSubview(episodeTitleLabel)
        view.addSubview(numberStackView)
    }
    
    func configureLayout() {
        episodeTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }

        lottoInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(episodeTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lottoInfoLabel)
            make.trailing.equalToSuperview().inset(16)
        }

        episodeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoInfoLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }

        numberStackView.snp.makeConstraints { make in
            make.top.equalTo(episodeTitleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func configureView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        episodeTextField.inputView = pickerView // 키보드대신
        
        updateLottoNumbers()
        
        episodeTextField.borderStyle = .roundedRect
        episodeTextField.placeholder = "회차 입력"
        episodeTextField.textAlignment = .center
        
        lottoInfoLabel.text = "당첨번호 안내"
        lottoInfoLabel.font = UIFont.systemFont(ofSize: 14)
        
        dateLabel.text = "2020-05-30 추첨"
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        
        numberStackView.axis = .horizontal
        numberStackView.spacing = 8
        numberStackView.alignment = .center
        numberStackView.distribution = .equalSpacing
        
        bonusLabel.text = "+"
        bonusLabel.font = UIFont.systemFont(ofSize: 20)
        
        bonusBall.text = "40"
        bonusBall.textAlignment = .center
        bonusBall.font = UIFont.boldSystemFont(ofSize: 16)
        bonusBall.backgroundColor = .lightGray
        bonusBall.textColor = .white
        bonusBall.layer.cornerRadius = 20
        bonusBall.layer.masksToBounds = true
        bonusBall.snp.makeConstraints { $0.size.equalTo(CGSize(width: 40, height: 40)) }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return episode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(episode[row])회"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedEpisode = episode[row]
        episodeTextField.text = "\(selectedEpisode)회"
        updateLottoNumbers()
    }
}
