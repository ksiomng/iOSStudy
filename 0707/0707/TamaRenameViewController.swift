//
//  ViewController.swift
//  0707
//
//  Created by Song Kim on 7/8/25.
//

import UIKit

class TamaRenameViewController: UIViewController {
    @IBOutlet private var ownerNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        setTextField()
    }
    
    private func setTextField() {
        let ownerName = UserDefaults.standard.string(forKey: "ownerName") ?? "이름정보가없습니다"
        ownerNameTextField.attributedPlaceholder = NSAttributedString(string: ownerName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        ownerNameTextField.borderStyle = .none
        ownerNameTextField.autocorrectionType = .no
        ownerNameTextField.spellCheckingType = .no
        ownerNameTextField.textColor = .black
    }
    
    @IBAction private func saveMyName(_ sender: UIBarButtonItem) {
        let oldName = UserDefaults.standard.string(forKey: "ownerName")
        if ownerNameTextField.text != "" {
            if ownerNameTextField.text == oldName {
                showAlret("기존 이름과 동일해요 ~")
            } else {
                UserDefaults.standard.set(ownerNameTextField.text, forKey: "ownerName")
                navigationController?.popViewController(animated: true)
            }
        } else {
            showAlret("이름 입력칸이 비었어요 !!")
        }
    }
    
    func showAlret(_ msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let btn = UIAlertAction(title: "확인", style: .default)
        alert.addAction(btn)
        present(alert, animated: true)
    }
}

