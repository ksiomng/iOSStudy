//
//  MainViewController.swift
//  0707
//
//  Created by Song Kim on 7/8/25.
//

import UIKit

struct Tamagotchi {
    var ownerName: String = "대장"
    var feedCount: Int = 0
    var waterCount: Int = 0
    var level: Int = 1
}

final class MainViewController: UIViewController {
    @IBOutlet private var bubbleImageView: UIImageView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var stateLabel: UILabel!
    @IBOutlet private var feedTextField: UITextField!
    @IBOutlet private var feedButton: UIButton!
    @IBOutlet private var waterTextField: UITextField!
    @IBOutlet private var waterButton: UIButton!
    
    var myTama = Tamagotchi()
    
    // 이름 바꾸고 돌아오면 이름을 다시 보여줘야함
    override func viewWillAppear(_ animated: Bool) {
        myData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bubbleImageView.image = UIImage(named: "bubble")
        
        setButtonTextFieldUI(btn: feedButton, textField: feedTextField, name: "밥")
        setButtonTextFieldUI(btn: waterButton, textField: waterTextField, name: "물")
        
        nameLabel.text = "싱글벙글 다마고치"
        radiusUI(nameLabel)
        
        navigationItem.backButtonTitle = "홈"
    }
    
    private func myData() {
        if let ownerName = UserDefaults.standard.string(forKey: "ownerName") {
            myTama.ownerName = ownerName
            myTama.feedCount = UserDefaults.standard.integer(forKey: "feedCount")
            myTama.waterCount = UserDefaults.standard.integer(forKey: "waterCount")
            myTama.level = UserDefaults.standard.integer(forKey: "level")
        } else {
            UserDefaults.standard.set(myTama.ownerName, forKey: "ownerName")
            UserDefaults.standard.set(myTama.feedCount, forKey: "feedCount")
            UserDefaults.standard.set(myTama.waterCount, forKey: "waterCount")
            UserDefaults.standard.set(myTama.level, forKey: "level")
        }
        updateStateLabel()
        updateTamaImage()
        navigationItem.title = "\(myTama.ownerName)의 다마고치"
        anyMessage()
    }
    
    private func setButtonTextFieldUI(btn: UIButton, textField: UITextField, name: String) {
        textField.borderStyle = .none
        textField.placeholder = "\(name)주세용"
        textField.keyboardType = .numberPad
        if name == "밥" {
            if let img = UIImage(systemName: "leaf.circle") {
                btn.setImage(img, for: .normal)
                btn.setTitle("  \(name)먹기", for: .normal)
                btn.tintColor = .black
            }
        } else {
            if let img = UIImage(systemName: "drop.circle") {
                btn.setImage(img, for: .normal)
                btn.setTitle("  \(name)먹기", for: .normal)
                btn.tintColor = .black
            }
        }
        radiusUI(btn)
    }
    
    private func radiusUI(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func addFeedCount(_ sender: UIButton) {
        if feedTextField.text == "" {
            myTama.feedCount += 1
        } else {
            if let cnt = Int(feedTextField.text!) {
                if cnt > 99 {
                    messageLabel.text = "다 먹으면 배부를꺼같아요 ㅠ"
                    feedTextField.text = ""
                    return
                } else {
                    myTama.feedCount += cnt
                    feedTextField.text = ""
                }
            } else {
                messageLabel.text = "몇개를 먹어야해요?"
                feedTextField.text = ""
                return
            }
        }
        UserDefaults.standard.set(myTama.feedCount, forKey: "feedCount")
        caculatorLevel()
        updateStateLabel()
    }
    
    @IBAction func addWaterCount(_ sender: UIButton) {
        if waterTextField.text == "" {
            myTama.waterCount += 1
        } else {
            if let cnt = Int(waterTextField.text!) {
                if cnt > 49 {
                    messageLabel.text = "\(myTama.ownerName), 다 먹으면 배부를꺼같아요 ㅠ"
                    waterTextField.text = ""
                    return
                } else {
                    myTama.waterCount += cnt
                    waterTextField.text = ""
                }
            } else {
                messageLabel.text = "\(myTama.ownerName), 몇개를 먹어야해요 ?"
                waterTextField.text = ""
                return
            }
        }
        UserDefaults.standard.set(myTama.waterCount, forKey: "waterCount")
        caculatorLevel()
        updateStateLabel()
    }
    
    @IBAction func resetButton(_ sender: Any) {
        myTama = Tamagotchi()
        UserDefaults.standard.set(myTama.ownerName, forKey: "ownerName")
        UserDefaults.standard.set(myTama.feedCount, forKey: "feedCount")
        UserDefaults.standard.set(myTama.waterCount, forKey: "waterCount")
        UserDefaults.standard.set(myTama.level, forKey: "level")
        updateStateLabel()
        updateTamaImage()
        anyMessage()
    }
    
    private func anyMessage() {
        let msg = [
            "안녕하세요 ~ \(myTama.ownerName) 반가워요 !",
            "\(myTama.ownerName)님 밥주세요 !",
            "좋은 하루에요 \(myTama.ownerName)님!",
        ]
        messageLabel.text = msg.randomElement()
    }
    
    private func updateStateLabel() {
        stateLabel.text = "LV\(myTama.level) * 밥알\(myTama.feedCount)개 * 물방울\(myTama.waterCount)개"
    }
    
    private func updateTamaImage() {
        profileImageView.image = UIImage(named: "2-\(myTama.level)")
    }
    
    private func caculatorLevel() {
        let result = (myTama.feedCount / 5) + (myTama.waterCount / 2)
        let newLevel = max(1,result/10)
        if newLevel > 9 { // 10은 이미지가 없어요
            myTama.level = 9
            messageLabel.text = "\(myTama.ownerName), 다 자랐어요 !"
        } else {
            if newLevel != myTama.level {
                myTama.level = newLevel
                messageLabel.text = "\(myTama.ownerName), 저 조금 자란거 같아요!"
            } else {
                let message = ["냠", "념", "냠 냠", "념 념"]
                messageLabel.text = message.randomElement()
            }
        }
        updateTamaImage()
        UserDefaults.standard.set(myTama.level, forKey: "level")
    }
}
