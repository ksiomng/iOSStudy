//
//  BMIViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Song Kim on 7/4/25.
//

import UIKit

// final 상속 못하게
// private class 로 햇더니 튕김 -> 스토리보드(외부)에서 outlet을 접근하려고하는데 private라 접근을 못해서 오류가 생김
final class BMIViewController: UIViewController {
    @IBOutlet private var heightTextField: UITextField!
    @IBOutlet private var weightTextField: UITextField!
    @IBOutlet private var calculateButton: UIButton!
    @IBOutlet private var randomBMIButton: UIButton!
    @IBOutlet private var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldUI()
        buttonUI()
        defaultLabelUI()
    }
    
    private func textFieldUI() {
        weightTextField.placeholder = "0초과 300미만의 숫자를 입력해주세요"
        weightTextField.keyboardType = .numberPad
        Design.radiusUI(weightTextField)
        
        heightTextField.placeholder = "0초과 300미만의 숫자를 입력해주세요"
        heightTextField.keyboardType = .numberPad
        Design.radiusUI(heightTextField)
    }
    
    private func buttonUI() {
        calculateButton.backgroundColor = .systemPink
        calculateButton.setTitle("계산하기", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        Design.radiusUI(calculateButton)
        
        randomBMIButton.setTitle("랜덤값보기", for: .normal)
        randomBMIButton.setTitleColor(.black, for: .normal)
        randomBMIButton.backgroundColor = .clear
    }
    
    private func defaultLabelUI() {
        resultLabel.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .medium)
        resultLabel.text = "알맞은 값을 입력하고 버튼을 눌러주세요"
        resultLabel.backgroundColor = .white
        Design.radiusUI(resultLabel)
    }
    
    // BMI 계산
    private func calculateBMI(weight: Double, height: Double) -> Double {
        let bmi = weight / ((height/100)*(height/100))
        return roundDouble(bmi)
    }
    
    // 소수점 2 자리까지
    private func roundDouble(_ num: Double) -> Double {
        let str = String(format: "%.2f", num)
        return Double(str) ?? 0.0
    }
    
    // 경고창
    private func showAlret(_ str: String) {
        let alret = UIAlertController(title: "⚠️", message: str, preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default, handler: nil)
        alret.addAction(yes)
        
        present(alret, animated: true, completion: nil)
    }
    
    @IBAction private func tapRandomBMIButton(_ sender: UIButton) {
        let height = roundDouble(Double.random(in: 10...300))
        let weight = roundDouble(Double.random(in: 1...300))
        
        weightTextField.text = "\(weight)"
        heightTextField.text = "\(height)"
        
        resultLabel.text = "BMI = \(calculateBMI(weight: weight, height: height))"
    }
    
    @IBAction private func tapCalculateButton(_ sender: UIButton) {
        if let height = exceptionTextField(heightTextField, str: "키"), let weight = exceptionTextField(weightTextField, str: "몸무개") {
            resultLabel.text = "BMI = \(calculateBMI(weight: weight, height: height))"
        }
    }
    
    private func exceptionTextField(_ textField: UITextField, str: String) -> Double? {
        if textField.text == "" { // 텍스트필드는 nil이 안나옴, 비어있으면 다 ""
            showAlret("\(str) 입력칸에 값을 입력해주세요")
        } else {
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
    
    // 버튼이랑도 연결 할 수 있어서 Any
    @IBAction private func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}
