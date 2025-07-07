//
//  DiaryViewController.swift
//  0701
//
//  Created by Song Kim on 7/1/25.
//

import UIKit

class DiaryViewController: UIViewController {
    var dic: [String: Int] = [:]
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var label1: UILabel!
    @IBOutlet var button2: UIButton!
    @IBOutlet var label2: UILabel!
    @IBOutlet var button3: UIButton!
    @IBOutlet var label3: UILabel!
    @IBOutlet var button4: UIButton!
    @IBOutlet var label4: UILabel!
    @IBOutlet var button5: UIButton!
    @IBOutlet var label5: UILabel!
    @IBOutlet var button6: UIButton!
    @IBOutlet var label6: UILabel!
    @IBOutlet var button7: UIButton!
    @IBOutlet var label7: UILabel!
    @IBOutlet var button8: UIButton!
    @IBOutlet var label8: UILabel!
    @IBOutlet var button9: UIButton!
    @IBOutlet var label9: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setImageUI()
        setDic()
    }
    func setImageUI() {
        button1.setImage(UIImage(named: "mono_slime1"), for: .normal)
        button1.setTitle("", for: .normal)
        
        button2.setImage(UIImage(named: "mono_slime2"), for: .normal)
        button2.setTitle("", for: .normal)
        
        button3.setImage(UIImage(named: "mono_slime3"), for: .normal)
        button3.setTitle("", for: .normal)
        
        button4.setImage(UIImage(named: "mono_slime4"), for: .normal)
        button4.setTitle("", for: .normal)
        
        button5.setImage(UIImage(named: "mono_slime5"), for: .normal)
        button5.setTitle("", for: .normal)
        
        button6.setImage(UIImage(named: "mono_slime6"), for: .normal)
        button6.setTitle("", for: .normal)
        
        button7.setImage(UIImage(named: "mono_slime7"), for: .normal)
        button7.setTitle("", for: .normal)
        
        button8.setImage(UIImage(named: "mono_slime8"), for: .normal)
        button8.setTitle("", for: .normal)
        
        button9.setImage(UIImage(named: "mono_slime9"), for: .normal)
        button9.setTitle("", for: .normal)
    }
    
    func setDic() {
        dic["행복해"] = 0
        dic["사랑해"] = 0
        dic["좋아해"] = 0
        dic["당황해"] = 0
        dic["속상해"] = 0
        dic["우울해"] = 0
        dic["심심해"] = 0
        dic["따분해"] = 0
        dic["지루해"] = 0
        
        setLabelUI()
    }
    
    func setLabelUI() {
        label1.text = "행복해 \(dic["행복해"]!)"
        label1.textAlignment = .center
        
        label2.text = "사랑해 \(dic["사랑해"]!)"
        label2.textAlignment = .center
        
        label3.text = "좋아해 \(dic["좋아해"]!)"
        label3.textAlignment = .center
        
        label4.text = "당황해 \(dic["당황해"]!)"
        label4.textAlignment = .center
        
        label5.text = "속상해 \(dic["속상해"]!)"
        label5.textAlignment = .center
        
        label6.text = "우울해 \(dic["우울해"]!)"
        label6.textAlignment = .center
        
        label7.text = "심심해 \(dic["심심해"]!)"
        label7.textAlignment = .center
        
        label8.text = "따분해 \(dic["따분해"]!)"
        label8.textAlignment = .center
        
        label9.text = "지루해 \(dic["지루해"]!)"
        label9.textAlignment = .center
    }

    @IBAction func tapButton1(_ sender: Any) {
        dic["행복해"]! += 1
        setLabelUI()
    }
    
    @IBAction func tapButton2(_ sender: Any) {
        dic["사랑해"]! += 1
        setLabelUI()
    }
    
    @IBAction func tapButton3(_ sender: Any) {
        dic["좋아해"]! += 1
        setLabelUI()
    }
    
    @IBAction func tapButton4(_ sender: Any) {
        dic["당황해"]! += 1
        setLabelUI()
    }
    
    @IBAction func tapButton5(_ sender: Any) {
        dic["속상해"]! += 1
        setLabelUI()
    }
   
    @IBAction func tapButton6(_ sender: Any) {
        dic["우울해"]! += 1
        setLabelUI()
    }
    
    @IBAction func tapButton7(_ sender: Any) {
        dic["심심해"]! += 1
        setLabelUI()
    }
    
    @IBAction func tapButton8(_ sender: Any) {
        dic["따분해"]! += 1
        setLabelUI()
    }
    
    @IBAction func tapButton9(_ sender: Any) {
        dic["지루해"]! += 1
        setLabelUI()
    }
    
}
