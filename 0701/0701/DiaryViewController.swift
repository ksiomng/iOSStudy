//
//  DiaryViewController.swift
//  0701
//
//  Created by Song Kim on 7/1/25.
//

import UIKit

class DiaryViewController: UIViewController {
    var emotionCounts: [String: Int] = [:] // dic, arr -> 네이밍 변경
    var emotions = ["행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "따분해", "지루해"]
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var labels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        for emotion in emotions {
            emotionCounts[emotion] = 0
        }
        
        for i in 0..<emotions.count { // 9 -> emotion.count로 변경
            setImageUI(btn: buttons[i], idx: i)
            setLabelUI(lbl: labels[i], idx: i)
        }
    }
    
    func setImageUI(btn: UIButton, idx: Int) {
        btn.setImage(UIImage(named: "mono_slime\(idx+1)"), for: .normal)
        btn.tag = idx // Title -> Tag 로 변경
    }
    
    func setLabelUI(lbl: UILabel, idx: Int) {
        let str = emotions[idx]
        lbl.text = "\(str) \(emotionCounts[str]!)"
        lbl.textAlignment = .center
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        let idx = sender.tag
        emotionCounts[emotions[idx]]! += 1
        setLabelUI(lbl: labels[idx], idx: idx)
    }
}
