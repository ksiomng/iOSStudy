//
//  UpDownMainViewController.swift
//  0718
//
//  Created by Song Kim on 7/17/25.
//

import UIKit

class UpDownMainViewController: UIViewController {
    
    @IBOutlet var mainEmotionImageView: UIImageView!
    @IBOutlet var rangeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        let randomImage = Int.random(in: 1...5)
        mainEmotionImageView.image = UIImage(named: "emotion\(randomImage)")
        rangeTextField.placeholder = "1 이상 300 이하의 숫자"
        rangeTextField.font = .systemFont(ofSize: 25, weight: .semibold)
        rangeTextField.textAlignment = .center
        rangeTextField.keyboardType = .numberPad
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        if rangeTextField.text != "" {
            if let range = Int(rangeTextField.text!) {
                rangeTextField.text = ""
                if range > 300 || range < 1 {
                    showAlert(msg: "1 이상 300 이하의 숫자를 입력해주세요")
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpDownViewController") as! UpDownViewController
                    vc.range = range
                    navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                rangeTextField.text = ""
                showAlert(msg: "숫자를 입력해주세요")
            }
        } else {
            rangeTextField.text = ""
            showAlert(msg: "입력된 값이 없습니다")
        }
    }
    
    @IBAction func closeKeyBoard(_ sender: Any) {
        view.endEditing(true)
    }
}
