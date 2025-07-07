//
//  NewHotViewController.swift
//  0702
//
//  Created by Song Kim on 7/2/25.
//

import UIKit

class NewHotViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        navigationItem.title = "NEW & HOT 검색"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        searchBar.searchTextField.textColor = .white
        
        defaultSetUI()
    }
    
    func defaultSetUI() {
        buttonStyle(btn: buttons[0], text: "공개 예정", imageName: "blue")
        buttonStyle(btn: buttons[1], text: "모두의 인기 콘텐츠", imageName: "turquoise")
        buttonStyle(btn: buttons[2], text: "TOP 10 시리즈", imageName: "pink")
        
        textLabel.text = "공개 예정 작품이 없습니다."
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 25)
        subLabel.text = "다른 영화, 시리즈, 배우, 감독 또는 장르를 검색해보세요"
        subLabel.textColor = .white
        subLabel.font = UIFont.systemFont(ofSize: 15)
        
        buttons[0].backgroundColor = .white
        buttons[0].tintColor = .black
    }
    
    @IBAction func tapFristButton(_ sender: Any) {
        textLabel.text = "공개 예정 작품이 없습니다."
        clickButtonUI(0)
    }
    
    @IBAction func tapSecondButton(_ sender: Any) {
        textLabel.text = "모두의 인기 콘텐츠 작품이 없습니다."
        clickButtonUI(1)
    }
    
    @IBAction func tapThirdButton(_ sender: Any) {
        textLabel.text = "TOP 10 시리즈 작품이 없습니다."
        clickButtonUI(2)
    }
    
    func clickButtonUI(_ idx: Int) {
        for i in 0..<3 {
            if i == idx {
                buttons[i].backgroundColor = .white
                buttons[i].tintColor = .black
            } else {
                buttons[i].backgroundColor = .black
                buttons[i].tintColor = .white
            }
        }
    }
    
    
    func buttonStyle(btn: UIButton, text: String, imageName: String) {
        btn.setTitle(text, for: .normal)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.backgroundColor = .black
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
    }
}
