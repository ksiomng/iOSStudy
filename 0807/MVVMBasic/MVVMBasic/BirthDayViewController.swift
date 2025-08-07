//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

// 에러핸들링 2번 Swift6 Type Throws
enum birthDayError: Error {
    case emptyString
    case isNotInt
    case year
    case month
    case day
}

class BirthDayViewController: UIViewController {
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
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
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
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
        view.endEditing(true)
        let year = yearTextField.text ?? ""
        let month = monthTextField.text ?? ""
        let day = dayTextField.text ?? ""
        
        do {
            let birthDate = try checkBirthDayError(year: year, month: month, day: day)
            let today = Date()
            let days = Calendar.current.dateComponents([.day], from: birthDate, to: today).day ?? 0
            resultLabel.text = "오늘은 \(days)일째입니다"
        } catch {
            switch error {
            case .emptyString:
                resultLabel.text = "년 월 일 모두 입력해주세요"
            case .isNotInt:
                resultLabel.text = "숫자를 입력해주세요"
            case .year:
                resultLabel.text = "1000년부터 2025년까지 중에 입력해주세요"
            case .month:
                resultLabel.text = "1월부터 12월중에 입력해주세요"
            case .day:
                resultLabel.text = "월에 맞는 일수를 입력해주세요"
            }
        }
    }
    
    func checkBirthDayError(year: String, month: String, day: String) throws(birthDayError) -> Date {
        guard !(year.isEmpty) && !(month.isEmpty) && !(day.isEmpty) else {
            throw .emptyString
        }
        guard Int(year) != nil && Int(month) != nil && Int(day) != nil else {
            throw .isNotInt
        }
        guard 1000 < Int(year)! && 2026 > Int(year)! else {
            throw .year
        }
        guard 0 < Int(month)! && Int(month)! <= 12 else {
            throw .month
        }
        guard 0 < Int(day)! && Int(day)! < checkDateRange(month: Int(month)!) else {
            throw .day
        }
        return stringToDate(year: year, month: month, day: day)
    }
    
    func checkDateRange(month: Int) -> Int {
        if month == 4 || month == 6 || month == 9 || month == 11 {
            return 30
        } else if month == 2 {
            return 28
        } else {
            return 31
        }
    }
    
    func stringToDate(year: String, month: String, day: String) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = Int(year)!
        dateComponents.month = Int(month)!
        dateComponents.day = Int(day)!
        
        let calendar = Calendar.current
        guard let birthDate = calendar.date(from: dateComponents) else {
            resultLabel.text = "날짜변환실패"
            return Date()
        }
        return birthDate
    }
}
