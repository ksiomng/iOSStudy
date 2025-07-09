//
//  TamaMainViewController.swift
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

final class TamaMainViewController: UIViewController {
    @IBOutlet private var bubbleImageView: UIImageView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var stateLabel: UILabel!
    @IBOutlet var feedTextField: [UITextField]!
    @IBOutlet var feedButton: [UIButton]!
    
    var myTama = Tamagotchi()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let defaultOwnerName = UserDefaults.standard.string(forKey: "ownerName") {
            // 이름이 바뀔때만 새로 화면을 그려줌
            if myTama.ownerName != defaultOwnerName {
                loadTama(defaultOwnerName)
                updateAllUI()
            }
        } else {
            createTama()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFirstUI()
    }
    
    private func setFirstUI() {
        bubbleImageView.image = UIImage(named: "bubble")
        nameLabel.text = "싱글벙글 다마고치"
        radiusUI(nameLabel)
        textFieldAndButtonUI()
        updateAllUI()
    }
    
    // 저장된 데이터 불러오기
    private func loadTama(_ ownerName: String) {
        myTama.ownerName = ownerName
        myTama.feedCount = UserDefaults.standard.integer(forKey: "feedCount")
        myTama.waterCount = UserDefaults.standard.integer(forKey: "waterCount")
        myTama.level = UserDefaults.standard.integer(forKey: "level")
    }
    
    // 새로운 데이터 생성 + 저장하기
    private func createTama() {
        myTama = Tamagotchi()
        UserDefaults.standard.set(myTama.ownerName, forKey: "ownerName")
        UserDefaults.standard.set(myTama.feedCount, forKey: "feedCount")
        UserDefaults.standard.set(myTama.waterCount, forKey: "waterCount")
        UserDefaults.standard.set(myTama.level, forKey: "level")
    }
    
    // 리셋버튼 누르면 새로운 데이터 생성
    @IBAction func resetButton(_ sender: UIButton) {
        createTama()
    }
    
    @IBAction func feedButtonTapped(_ sender: UIButton) {
        let idx = sender.tag - 1
        if feedTextField[idx].text == "" {
            applyFeedCount(sender.tag, cnt: 1)
        } else {
            let cnt = idx == 0 ? 99 : 49
            tryFeedingWithInput(limit: cnt, textField: feedTextField[idx])
        }
    }
    
    // 밥을 주고 먹을 수 있는 지 없는지 검사하는? 함수 (textField)
    private func tryFeedingWithInput(limit: Int, textField: UITextField) {
        if let cnt = Int(textField.text!) {
            if cnt > limit {
                messageLabel.text = "다 먹으면 배부를꺼같아요 ㅠ"
                textField.text = ""
                return
            } else {
                applyFeedCount(textField.tag, cnt: cnt)
                textField.text = ""
            }
        } else {
            messageLabel.text = "몇개를 먹어야해요?"
            textField.text = ""
            return
        }
    }
    
    // 밥 주는만큼 더하는 함수
    private func applyFeedCount(_ tag: Int, cnt: Int) {
        if tag == 1 {
            myTama.feedCount += cnt
            UserDefaults.standard.set(myTama.feedCount, forKey: "feedCount")
        } else {
            myTama.waterCount += cnt
            UserDefaults.standard.set(myTama.feedCount, forKey: "waterCount")
        }
        updateLevelIf()
        updateStateLabel()
    }
    
    // 레벨이 오를때마다 바꿔주는 함수 + 먹었을 때 UI
    private func updateLevelIf() {
        let result = (myTama.feedCount / 5) + (myTama.waterCount / 2)
        let newLevel = max(1,result/10)
        
        if newLevel > 9 {
            myTama.level = 9
            messageLabel.text = "\(myTama.ownerName), 다 자랐어요 !"
        } else {
            // 레벨이 올랐을때만
            if newLevel != myTama.level {
                myTama.level = newLevel
                messageLabel.text = "\(myTama.ownerName), 저 조금 자란거 같아요!"
                updateTamaImage()
                UserDefaults.standard.set(myTama.level, forKey: "level")
            } else {
                let message = ["냠", "념", "냠 냠", "념 념"]
                messageLabel.text = message.randomElement()
            }
        }
    }
    
    // 데이터가 싹 다 바뀌었을 때 or 새로 다 불러올 때
    private func updateAllUI() {
        updateStateLabel()
        updateTamaImage()
        navigationItem.title = "\(myTama.ownerName)의 다마고치"
        showRandomMessage()
    }
    
    private func textFieldAndButtonUI() {
        for text in feedTextField {
            textFieldUI(text)
        }
        for btn in feedButton {
            buttonUI(btn)
        }
    }
    
    private func textFieldUI(_ textField: UITextField) {
        let name = textField.tag == 1 ? "밥" : "물"
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: "\(name)주세용", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.keyboardType = .numberPad
    }
    
    private func buttonUI(_ btn: UIButton) {
        let name = btn.tag == 1 ? "밥" : "물"
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
    
    // 랜덤으로 보여주는 메인 문구
    private func showRandomMessage() {
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
}
