//
//  BMIViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Song Kim on 7/4/25.
//

import UIKit

class BMIViewController: UIViewController {
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var randomBMIButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldUI()
        buttonUI()
        defaultLabelUI()
    }
    
    func textFieldUI() {
        weightTextField.placeholder = "0초과 300미만의 숫자를 입력해주세요"
        weightTextField.keyboardType = .numberPad
        radiusUI(weightTextField)
        
        heightTextField.placeholder = "0초과 300미만의 숫자를 입력해주세요"
        heightTextField.keyboardType = .numberPad
        radiusUI(heightTextField)
    }
    
    func buttonUI() {
        calculateButton.backgroundColor = .systemPink
        calculateButton.setTitle("계산하기", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        radiusUI(calculateButton)
        
        randomBMIButton.setTitle("랜덤값보기", for: .normal)
        randomBMIButton.setTitleColor(.black, for: .normal)
        randomBMIButton.backgroundColor = .clear
    }
    
    func defaultLabelUI() {
        resultLabel.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .medium)
        resultLabel.text = "알맞은 값을 입력하고 버튼을 눌러주세요"
        resultLabel.backgroundColor = .white
        radiusUI(resultLabel)
    }
    
    func radiusUI(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
    }
    
    // BMI 계산
    func calculateBMI(weight: Double, height: Double) -> Double {
        let bmi = weight / ((height/100)*(height/100))
        return roundDouble(bmi)
    }
    
    // 소수점 2 자리까지
    func roundDouble(_ num: Double) -> Double {
        let str = String(format: "%.2f", num)
        return Double(str) ?? 0.0
    }
    
    // 경고창
    func showAlret(_ str: String) {
        let alret = UIAlertController(title: "⚠️", message: str, preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default, handler: nil)
        alret.addAction(yes)
        
        present(alret, animated: true, completion: nil)
    }
    
    @IBAction func tapRandomBMIButton(_ sender: Any) {
        let height = roundDouble(Double.random(in: 10...300))
        let weight = roundDouble(Double.random(in: 1...300))
        
        weightTextField.text = "\(weight)"
        heightTextField.text = "\(height)"
        
        resultLabel.text = "BMI = \(calculateBMI(weight: weight, height: height))"
    }
    
    @IBAction func tapCalculateButton(_ sender: UIButton) {
        if let height = exceptionTextField(heightTextField, str: "키"), let weight = exceptionTextField(weightTextField, str: "몸무개") {
            resultLabel.text = "BMI = \(calculateBMI(weight: weight, height: height))"
        }
    }
    
    func exceptionTextField(_ textField: UITextField, str: String) -> Double? {
        if textField.text == "" {
            showAlret("\(str) 입력칸에 값을 입력해주세요")
        } else {
            if let value = Double(heightTextField.text!){
            if let value = Double(textField.text!){
                if value >= 300 || value < 0 {
                    showAlret("0초과 300이하의 \(str)를 입력해주세요")
                } else {
                    return roundDouble(value)
                }
            } else {
                showAlret("\(str) 입력칸에 \"숫자\"를 입력해주세요")
            }
        }
        textField.text = ""
        return nil
    }
    
    @IBAction func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}
