//
//  ViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Jack on 7/3/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "버튼을 클릭하세요"
    }
    
    @IBAction func zodiacSignsTapped(_ sender: UIButton) {
        getZodiacSign(month: Int.random(in: 1...12))
    }
    
    func getZodiacSign(month: Int) {
        var constellation = ""
        
        switch month {
        case 1: constellation = "♒ 물병자리"
        case 2: constellation = "♓ 물고기자리"
        case 3: constellation = "♈ 양자리"
        case 4: constellation = "♉ 황소자리"
        case 5: constellation = "♊ 쌍둥이자리"
        case 6: constellation = "♋ 게자리"
        case 7: constellation = "♌ 사자자리"
        case 8: constellation = "♍ 처녀자리"
        case 9: constellation = "♎ 천칭자리"
        case 10: constellation = "♏ 전갈자리"
        case 11: constellation = "♐ 사수자리"
        case 12: constellation = "♑ 염소자리"
        default: constellation = "없음"
        }
        
        resultLabel.text = "\(month)월은 \(constellation)자리입니다."
    }
    
    @IBAction func recommandGameJob(_ sender: UIButton) {
        let strength = Int.random(in: 1...100)
        let agility = Int.random(in: 1...100)
        getRecommandGameJob(strength: strength, agility: agility)
    }
    
    func getRecommandGameJob(strength: Int, agility: Int) {
        
        if strength > agility {
            resultLabel.text = "strength(힘)이 가장 높으니 전사를 추천드립니다."
        } else if strength < agility {
            resultLabel.text = "agility(민첩)이 가장 높으니 도적을 추천드립니다."
        } else {
            resultLabel.text = "strength(힘)과 agility(민첩)이 같으니 마법사를 추천드립니다"
        }
    }
    
    @IBAction func recommandClothing(_ sender: UIButton) {
        let temp = Int.random(in: -30...50)
        let rain = Bool.random()
        
        getRecommandClothing(temperature: temp, isRaining: rain)
    }
    
    func getRecommandClothing(temperature: Int, isRaining: Bool) {
        var resultString = ""
        
        switch temperature/10 {
        case -3...0:
            resultString = "지금 온도가 \(temperature)이니 패딩을 입으세요. 🏂\n"
        case 1...2:
            resultString = "지금 온도가 \(temperature)이니 긴팔을 입으세요. 🧥\n"
        case 2...3:
            resultString = "지금 온도가 \(temperature)이니 반팔을 입으세요. 👕\n"
        default:
            resultString = "지금 온도가 \(temperature)이니 나가지마세요. 🏠\n"
        }
        
        if isRaining {
            resultString += "비가오니 우산을 챙겨야 됩니다. ☔"
        } else {
            resultString += "비가 오지 않으니 우산을 안챙겨도 됩니다. 🌂"
        }
        
        resultLabel.text = resultString
    }
    
    @IBAction func evaluateGrade(_ sender: UIButton) {
        var sum = 0
        
        let data = [3, 27, 64, 89, 7, 12, 45, 78, 14, 29, 56, 92, 1, 33, 67, 85, 9, 21, 48, 76, 18, 41, 63, 94, 5, 30, 52, 87, 11, 26, 59, 81, 15, 37, 70, 96, 2, 34, 61, 83, 8, 23, 49, 90, 17, 39, 65, 98, 4, 28, 53, 79, 12, 36, 68, 91, 6, 31, 57, 84, 19, 42, 66, 95, 10, 25, 51, 88, 16, 38, 60, 97, 13, 32, 55, 82, 20, 44, 69, 93, 3, 29, 62, 86, 7, 35, 58, 80, 14, 40, 64, 99, 1, 24, 50, 77, 9, 33, 67, 92, 18, 46, 71, 85, 5, 27, 54, 89, 11, 39, 63, 96, 15, 34, 59, 81, 2, 30, 65, 94, 8, 41, 68, 87, 17, 37, 52, 90, 4, 26, 61, 83, 12, 43, 70, 98, 6, 28, 56, 79, 19, 45, 66, 91, 10, 32, 58, 84, 16, 40, 62, 95, 13, 25, 51, 88, 20, 38, 69, 97, 3, 31, 57, 82, 7, 36, 64, 93, 14, 29, 50, 86, 1, 42, 67, 80, 9, 34, 61, 99, 18, 27, 55, 92, 5, 39, 68, 85, 11, 33, 60, 94, 15, 46, 71]
        
        data.forEach { score in
            sum += score
        }
        
        resultLabel.text = "\(data.count)명의 평균 점수는 \(Double(sum/data.count))점입니다."
    }
    
    @IBAction func countFruits(_ sender: UIButton) {
        var fruitsCountDic = [String: Int]()
        var resultString = ""
        
        let fruits = ["체리", "딸기", "사과", "멜론", "망고", "오렌지", "오렌지", "키위", "딸기", "사과", "복숭아", "포도", "배", "바나나", "오렌지", "배", "포도", "참외", "사과", "블루베리", "오렌지", "오렌지", "바나나", "사과", "수박", "포도", "딸기", "체리", "사과", "자두", "멜론", "멜론", "수박", "파인애플", "참외", "참외", "바나나", "멜론", "사과", "사과", "자두", "딸기", "바나나", "석류", "라임", "키위", "자두", "사과", "오렌지", "자두", "레몬", "바나나", "사과", "수박", "체리", "사과", "블루베리", "딸기", "바나나", "수박", "체리", "사과", "복숭아", "수박", "참외", "오렌지", "바나나", "참외", "오렌지", "바나나", "체리", "딸기", "바나나", "감", "감", "키위", "자두", "포도", "파인애플", "포도", "사과", "포도", "블루베리", "포도", "바나나", "사과", "망고", "복숭아", "레몬", "사과", "자두", "복숭아", "포도", "오렌지", "오렌지", "수박", "망고", "사과", "블루베리", "감", "바나나", "딸기", "바나나"]
        
        for fruit in fruits {
            if fruitsCountDic.keys.contains(fruit) {
                fruitsCountDic[fruit]! += 1
            } else {
                fruitsCountDic[fruit] = 1
            }
        }
        
        fruitsCountDic.forEach { name, cnt in
            if fruitsCountDic.count == 1 {
                resultString += "\(name): \(cnt)" //마지막 문자는 , 가 없어야함
            } else {
                resultString += "\(name): \(cnt), "
            }
            fruitsCountDic.removeValue(forKey: name)
        }
        
        resultLabel.text = resultString
    }
}

