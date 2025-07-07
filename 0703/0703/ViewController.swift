//
//  ViewController.swift
//  0703
//
//  Created by Song Kim on 7/3/25.
//

import UIKit

// 접근제어자
final class ViewController: UIViewController {
    let dic: [String: String] = ["감다살": "감이 다 살아났다", "감다뒤": "감이 다 뒤졌다", "막나귀": "막상 나가려니 귀찮다", "아보하": "아주 보통의 하루", "싹싹김치": "좋다, 잘됐다 등의 감탄사", "일세스코": "열심히 일하는 동료를 방해하는 사람", "섹시푸드": "비주얼도 좋고 맛도 좋은 음식", "JMT": "매우 맛있다"]
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchQuickButtons: [UIButton]!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setQuickButtons()
        setSearchTextFieldUI()
    }
    
   private func setSearchTextFieldUI() {
        searchTextField.placeholder = "궁금한 신조어를 검색해주세요"
        searchTextField.layer.borderWidth = 2
        searchTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    func setQuickButtons() {
        var quickMenu = dic
        for i in 0..<searchQuickButtons.count {
            let random = quickMenu.randomElement()
            searchQuickButtons[i].setTitle(random?.key, for: .normal)
            quickButtonUI(btn: searchQuickButtons[i])
            quickMenu.removeValue(forKey: random?.key ?? "")
        }
    }
    
    func quickButtonUI(btn: UIButton) {
        btn.setTitleColor(.black, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
    }
    
    func setLabel(key: String?) {
        // 텍스트필드는 nil이 없음 -> 비어있으면 무조건 "" 근데 이제 옵셔널인 이유는 objecive-c 와의 호환때문에
        if let text = key {
            if text.isEmpty {
                resultLabel.text = "검색값을 입력해주세요"
            } else {
                resultLabel.text = dic[text.uppercased()] ?? "검색결과가 없습니다"
            }
        }
    }

    @IBAction func enterSearch(_ sender: UIButton) {
        setLabel(key: searchTextField.text)
    }
    
    @IBAction func tapSearchButton(_ sender: UIButton) {
        setLabel(key: searchTextField.text)
    }
    
    @IBAction func tapQuickButton(_ sender: UIButton) {
        setLabel(key: sender.currentTitle)
        searchTextField.text = sender.currentTitle
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
}
