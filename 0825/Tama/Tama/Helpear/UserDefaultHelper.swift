//
//  UserDefaultHelper.swift
//  Tama
//
//  Created by Song Kim on 8/23/25.
//

import UIKit

final class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    private let defaults = UserDefaults.standard
    
    private init() { }
    
    var colonName: String? {
        get {
            return defaults.string(forKey: "colonName")
        }
        set {
            return defaults.set(newValue, forKey: "colonName")
        }
    }
    
    func checkData() -> [Tama] {
        var tamas: [Tama] = []
        if colonName == nil {
            setFirstTama()
        }
        for i in 0..<20 {
            tamas.append(getTamaData(num: i))
        }
        return tamas
    }
    
    var tamaNames: [String]? {
        get {
            return defaults.array(forKey: "tamaNames") as? [String]
        }
        set {
            return defaults.set(newValue, forKey: "tamaNames")
        }
    }
    
    var rice: [Int]? {
        get {
            return defaults.array(forKey: "rice") as? [Int]
        }
        set {
            return defaults.set(newValue, forKey: "rice")
        }
    }
    
    var water: [Int]? {
        get {
            return defaults.array(forKey: "water") as? [Int]
        }
        set {
            return defaults.set(newValue, forKey: "water")
        }
    }
    
    func getTamaData(num: Int) -> Tama {
        let name = tamaNames?[num] ?? ""
        let riceVal = rice?[num] ?? 0
        let waterVal = water?[num] ?? 0
        return Tama(name: name, rice: riceVal, water: waterVal)
    }
    
    func updateTamaData(num: Int, rice: Int, water: Int) {
        self.rice![num] = rice
        self.water![num] = water
    }
    
    func checkLevel(num: Int) -> Int {
        let exp = (rice![num] / 5) + (water![num] / 2)
        return min(exp / 10 + 1, 10)
    }
    
    func getTamaImage(num: Int) -> UIImage {
        return UIImage(named: "\(num+1)-\(min(checkLevel(num: num), 9))") ?? UIImage(named: "noImage")!
    }
    
    private func setFirstTama() {
        colonName = "대장"
        tamaNames = Array(repeating: "준비중이에요", count: 20)
        rice = Array(repeating: 0, count: 20)
        water = Array(repeating: 0, count: 20)
        
        tamaNames![0] = "따끔따끔 다마고치"
        tamaNames![1] = "방실방실 다마고치"
        tamaNames![2] = "반짝반짝 다마고치"
    }
}
