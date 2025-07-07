//
//  DiaryViewController.swift
//  0701
//
//  Created by Song Kim on 7/1/25.
//

import UIKit

class DiaryViewController: UIViewController {
    var dic: [String: Int] = [:]
    var arr = ["행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "따분해", "지루해"]
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var labels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        for a in arr {
            dic[a] = 0
        }
        
        for i in 0..<9 {
            setImageUI(btn: buttons[i], idx: i)
            setLabelUI(lbl: labels[i], idx: i)
        }
    }
    
    func setImageUI(btn: UIButton, idx: Int) {
        btn.setImage(UIImage(named: "mono_slime\(idx+1)"), for: .normal)
        btn.setTitle("\(idx)", for: .normal)
    }
    
    func setLabelUI(lbl: UILabel, idx: Int) {
        let str = arr[idx]
        lbl.text = "\(str) \(dic[str]!)"
        lbl.textAlignment = .center
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        let idx = Int(sender.currentTitle ?? "0")!
        dic[arr[idx]]! += 1
        setLabelUI(lbl: labels[idx], idx: idx)
    }
}
