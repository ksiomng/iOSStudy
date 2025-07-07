//
//  SONGFLIXViewController.swift
//  0701
//
//  Created by Song Kim on 7/1/25.
//

import UIKit

class SONGFLIXViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailTextLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordTextLabel: UILabel!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nicknameTextLabel: UILabel!
    
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var advisecodeTextField: UITextField!
    
    @IBOutlet var signButton: UIButton!
    @IBOutlet var addInfoLabel: UILabel!
    @IBOutlet var addInfoSwitch: UISwitch!
    
    @IBOutlet var emailCheckImage: UIImageView!
    @IBOutlet var passwordCheckImage: UIImageView!
    @IBOutlet var nicknameCheckImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        titleLabelUI()
        emailTextFieldUI()
        passwordTextFieldUI()
        nicknameTextFieldUI()
        addressTextFieldUI()
        advisecodeTextFieldUI()
        signButtonUI()
        addInfoUI()
        defaultImageUI()
    }
    
    func defaultImageUI() {
        emailCheckImage.tintColor = .gray
        emailCheckImage.image = UIImage(systemName: "xmark.seal")
        
        passwordCheckImage.tintColor = .gray
        passwordCheckImage.image = UIImage(systemName: "xmark.seal")
        
        nicknameCheckImage.tintColor = .gray
        nicknameCheckImage.image = UIImage(systemName: "xmark.seal")
    }
    
    func titleLabelUI() {
        titleLabel.text = "SONGFLIX"
        titleLabel.font = UIFont.monospacedSystemFont(ofSize: 30, weight: .heavy)
        titleLabel.textColor = .red
        titleLabel.textAlignment = NSTextAlignment.center
    }
    
    // MARK: Email
    func emailTextFieldUI() {
        emailTextField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray5])
        emailTextField.textAlignment = NSTextAlignment.center
        emailTextField.backgroundColor = .gray
        emailTextField.textColor = .white
        
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 6
        
        emailTextLabel.text = "@를 포함시켜주세요"
        emailTextLabel.textColor = .white
        emailTextLabel.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
    }
    
    @IBAction func emailEditingChanged(_ sender: Any) {
        emailCheckUI(isChecked: ((emailTextField.text?.contains("@")) != nil))
    }
    
    func emailCheckUI(isChecked: Bool) {
        if isChecked {
            emailCheckImage.tintColor = .red
            emailCheckImage.image = UIImage(systemName: "checkmark.seal")
        } else {
            emailCheckImage.tintColor = .gray
            emailCheckImage.image = UIImage(systemName: "xmark.seal")
        }
    }
    
    // MARK: Password
    func passwordTextFieldUI() {
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray5])
        passwordTextField.textAlignment = NSTextAlignment.center
        passwordTextField.backgroundColor = .gray
        passwordTextField.textColor = .white
        
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 6
        
        passwordTextLabel.text = "8글자 이상 작성해주세요"
        passwordTextLabel.textColor = .white
        passwordTextLabel.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
    }
    
    @IBAction func passwordEditingChanged(_ sender: Any) {
        passwordCheckUI(isChecked: passwordTextField.text!.count > 9)
    }
    
    func passwordCheckUI(isChecked: Bool) {
        if isChecked {
            passwordCheckImage.tintColor = .red
            passwordCheckImage.image = UIImage(systemName: "checkmark.seal")
        } else {
            passwordCheckImage.tintColor = .gray
            passwordCheckImage.image = UIImage(systemName: "xmark.seal")
        }
    }
    
    // MARK: Nickname
    func nicknameTextFieldUI() {
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray5])
        nicknameTextField.textAlignment = NSTextAlignment.center
        nicknameTextField.backgroundColor = .gray
        nicknameTextField.textColor = .white
        
        nicknameTextField.clipsToBounds = true
        nicknameTextField.layer.cornerRadius = 6
        
        nicknameTextLabel.text = "2글자 이상 10글자 이하로 작성해주세요"
        nicknameTextLabel.textColor = .white
        nicknameTextLabel.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
    }
    
    @IBAction func nicknameEditingChanged(_ sender: Any) {
        if nicknameTextField.text!.count < 11 && nicknameTextField.text!.count > 2 {
            nicknameCheckUI(isChecked: true)
        } else {
            nicknameCheckUI(isChecked: false)
        }
    }
    
    func nicknameCheckUI(isChecked: Bool) {
        if isChecked {
            nicknameCheckImage.tintColor = .red
            nicknameCheckImage.image = UIImage(systemName: "checkmark.seal")
        } else {
            nicknameCheckImage.tintColor = .gray
            nicknameCheckImage.image = UIImage(systemName: "xmark.seal")
        }
    }
    
    func addressTextFieldUI() {
        addressTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray5])
        addressTextField.textAlignment = NSTextAlignment.center
        addressTextField.backgroundColor = .gray
        addressTextField.textColor = .white
        
        addressTextField.clipsToBounds = true
        addressTextField.layer.cornerRadius = 6
    }
    
    func advisecodeTextFieldUI() {
        advisecodeTextField.attributedPlaceholder = NSAttributedString(string: "추천 코드 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray5])
        advisecodeTextField.textAlignment = NSTextAlignment.center
        advisecodeTextField.backgroundColor = .gray
        advisecodeTextField.textColor = .white
        
        advisecodeTextField.clipsToBounds = true
        advisecodeTextField.layer.cornerRadius = 6
    }
    
    func signButtonUI() {
        signButton.setTitle("회원가입", for: .normal)
        signButton.setTitleColor(.black, for: .normal)
        signButton.backgroundColor = .white
        
        signButton.clipsToBounds = true
        signButton.layer.cornerRadius = 6
    }
    
    func addInfoUI() {
        addInfoLabel.text = "추가 정보 입력"
        addInfoLabel.textColor = .white
        
        addInfoSwitch.onTintColor = .red
        hiddenTextFieldUI()
    }
    
    // 스위치로 상태 따라서 텍스트필드 보여주기
    @IBAction func showAddInfoSwitch(_ sender: Any) {
        hiddenTextFieldUI()
    }
    
    func hiddenTextFieldUI() {
        if addInfoSwitch.isOn {
            advisecodeTextField.isHidden = false
            addressTextField.isHidden = false
        } else {
            advisecodeTextField.isHidden = true
            addressTextField.isHidden = true
        }
    }
    
    // 키보드 닫기
    @IBAction func emailDidEndOnExit(_ sender: Any) {
    }
    
    @IBAction func passwordDidEndOnExit(_ sender: Any) {
    }
    
    @IBAction func nicknameDidEndOnExit(_ sender: Any) {
    }
    
    @IBAction func addressDidEndOnExit(_ sender: Any) {
    }
    
    @IBAction func adviseDidEndOnExit(_ sender: Any) {
    }
}
