//
//  HomeViewController.swift
//  0702
//
//  Created by Song Kim on 7/2/25.
//

import UIKit

class HomeViewController: UIViewController {
    var imageNames = ["노량", "더퍼스트슬램덩크", "명량", "밀수", "범죄도시3", "서울의봄", "스즈메의문단속", "아바타물의길", "오펜하이머", "육사오", "콘크리트유토피아"]

    @IBOutlet var images: [UIImageView]!
    @IBOutlet var randomImageButton: UIButton!
    @IBOutlet var randomMiniImageButton: UIButton!
    @IBOutlet var miniImages: [UIImageView]!
    @IBOutlet var miniLabels: [UILabel]!
    @IBOutlet var radiusView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SONG님"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = .black
        randomIamge()
        randomButtonUI()
        randomMiniImage()
        randomMiniButtonUI()
    }
    
    func randomButtonUI() {
        randomImageButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        randomImageButton.setTitle("포스터 랜덤", for: .normal)
        randomImageButton.tintColor = .black
        randomImageButton.backgroundColor = .white
        randomImageButton.clipsToBounds = true
        randomImageButton.layer.cornerRadius = 5
    }
    
    func randomMiniButtonUI() {
        randomMiniImageButton.setImage(UIImage(systemName: "plus"), for: .normal)
        randomMiniImageButton.setTitle("미니 랜덤", for: .normal)
        randomMiniImageButton.tintColor = .white
        randomMiniImageButton.backgroundColor = .gray
        randomMiniImageButton.clipsToBounds = true
        randomMiniImageButton.layer.cornerRadius = 5
    }
    
    @IBAction func tapRandomMiniImage(_ sender: Any) {
        randomMiniImage()
    }
    
    func randomMiniImage() {
        for i in 0..<3 {
            miniImages[i].image = UIImage(named: "top10badge")
            let b = Bool.random()
            miniImages[i].isHidden = b
        }
        for i in 0..<6 {
            miniLabels[i].font = UIFont.systemFont(ofSize: 10)
            let b = Bool.random()
            miniLabels[i].isHidden = b
            
            if i%2 == 0 {
                miniLabels[i].text = "새로운 에피소드"
                miniLabels[i].textColor = .white
                miniLabels[i].backgroundColor = .red
            } else {
                miniLabels[i].text = "지금 시청하기"
                miniLabels[i].textColor = .black
                miniLabels[i].backgroundColor = .white
            }
        }
    }
    
    @IBAction func tapRandomImageButton(_ sender: Any) {
        randomIamge()
    }
    
    func randomIamge() {
        coneradius(img: images[0])
        for i in 0..<4 {
            let randomIamge = imageNames.randomElement()
            images[i].image = UIImage(named: randomIamge ?? "명량")
        }
        for i in 0..<3 {
            coneradius(img: radiusView[i])
        }
    }
    
    func coneradius(img: UIView) {
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
    }
}
