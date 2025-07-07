//
//  SaveViewController.swift
//  0702
//
//  Created by Song Kim on 7/2/25.
//

import UIKit

class SaveViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        navigationItem.title = "저장한 콘텐츠 목록"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        mainLabel.text = "'나만의 자동 저장'기능"
        mainLabel.textColor = .white
        mainLabel.font = UIFont.systemFont(ofSize: 25)
        
        subLabel.text = "취향에 맞는 영화와 시리즈를 자동으로 저장해 드립니다. 디바이스에 언제나 시청할 콘텐츠가 준비되니 지루할 틈이 없어요."
        subLabel.textColor = .white
        subLabel.font = UIFont.systemFont(ofSize: 15)
        
        mainImage.image = UIImage(named: "dummy")
        
        button1.setTitle("설정하기", for: .normal)
        button1.backgroundColor = .blue
        button1.tintColor = .white
        button1.clipsToBounds = true
        button1.layer.cornerRadius = 10
        
        button2.setTitle("저장 가능한 콘텐츠 살펴보기", for: .normal)
        button2.backgroundColor = .white
        button2.tintColor = .black
        button2.clipsToBounds = true
        button2.layer.cornerRadius = 10
    }
}
