//
//  LottoViewController.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class LottoViewController: UIViewController {
    
    lazy var episodeTextField = {
        let textField = UITextField()
        textField.inputView = pickerView // 키보드대신
        textField.borderStyle = .roundedRect
        textField.placeholder = "회차 입력"
        textField.textAlignment = .center
        return textField
    }()
    
    let lottoInfoLabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    var episodeNumberLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .systemYellow
        return label
    }()
    
    var episodeTextLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "당첨결과"
        return label
    }()
    
    let numberStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    lazy var pickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    var episodeList = [Int]()
    
    var selectedEpisode = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func recentLotto() -> Int {
        let startLotto = DateComponents(year: 2002, month: 12, day: 2) // 로또 1회차
        let startDate = Calendar.current.date(from: startLotto)!
        
        let offsetComps = Calendar.current.dateComponents([.day], from: startDate, to: Date()) // 오늘과 비교
        guard let day = offsetComps.day else {
            return 1
        }
        return day/7 // 회차계산
    }
    
    func fetchLottoData(drwNo: Int){
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let res):
                    print(res)
                    let numbers = self.arrLottoNumber(lottoData: res)
                    self.updateLottoNumbers(numbers: numbers)
                    self.episodeNumberLabel.text = "\(res.drwNo)회"
                    self.dateLabel.text = res.drwNoDate
                case .failure(let err):
                    print(err)
                }
            }
    }
    
    func arrLottoNumber(lottoData: Lotto) -> [Int] {
        var arr: [Int] = []
        arr.append(lottoData.drwtNo1)
        arr.append(lottoData.drwtNo2)
        arr.append(lottoData.drwtNo3)
        arr.append(lottoData.drwtNo4)
        arr.append(lottoData.drwtNo5)
        arr.append(lottoData.drwtNo6)
        arr.append(lottoData.bnusNo)
        return arr
    }
    
    func updateLottoNumbers(numbers: [Int]) {
        numberStackView.clear()
        
        for i in 0..<6 {
            let ball = createBallLabel(number: numbers[i])
            numberStackView.addArrangedSubview(ball)
        }
        
        let bonusLabel = {
            let label = UILabel()
            label.text = "+"
            label.font = UIFont.systemFont(ofSize: 20)
            return label
        }()
        
        numberStackView.addArrangedSubview(bonusLabel)
        let bonusBall = createBallLabel(number: numbers.last!, bnus: true)
        numberStackView.addArrangedSubview(bonusBall)
    }
    
    func createBallLabel(number: Int, bnus: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = "\(number)"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        if bnus {
            label.backgroundColor = .gray
        } else {
            label.backgroundColor = selectColor(number)
        }
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
            return .systemYellow
        case 11...20:
            return .systemTeal
        case 21...30:
            return .systemIndigo
        case 31...40:
            return .systemPink
        case 41...45:
            return .systemGray
        default:
            return .systemGray
        }
        
    }
}

extension LottoViewController: ViewDesignProtocol {
    
    func configureHierarchy() {
        view.addSubview(episodeTextField)
        view.addSubview(lottoInfoLabel)
        view.addSubview(dateLabel)
        view.addSubview(episodeNumberLabel)
        view.addSubview(episodeTextLabel)
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
        
        episodeTextLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(40)
            make.centerY.equalTo(episodeNumberLabel.snp.centerY)
        }
        
        episodeNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoInfoLabel.snp.bottom).offset(16)
            make.trailing.equalTo(episodeTextLabel.snp.leading).offset(-5)
        }
        
        numberStackView.snp.makeConstraints { make in
            make.top.equalTo(episodeNumberLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        let episode = recentLotto()
        episodeList = Array(1...episode)
        fetchLottoData(drwNo: episode)
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return episodeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(episodeList[row])회"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedEpisode = episodeList[row]
        fetchLottoData(drwNo: selectedEpisode)
    }
}
