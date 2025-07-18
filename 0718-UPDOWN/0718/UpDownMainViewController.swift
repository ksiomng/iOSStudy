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
        let randomInt = Int.random(in: 1...5)
        mainEmotionImageView.image = UIImage(named: "emotion\(randomInt)")
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        if rangeTextField.text != "" {
            if let range = Int(rangeTextField.text!) {
                rangeTextField.text = ""
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpDownViewController") as! UpDownViewController
                vc.range = min(range, 300)
                navigationController?.pushViewController(vc, animated: true)
            } else {
                rangeTextField.text = ""
                rangeTextField.placeholder = "숫자를 입력해주세요"
            }
        } else {
            rangeTextField.text = ""
            rangeTextField.placeholder = "입력된 값이 없습니다"
        }
    }
}
