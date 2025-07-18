//
//  UpDownViewController.swift
//  0718
//
//  Created by Song Kim on 7/17/25.
//

import UIKit

class UpDownViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var listCollectionView: UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var resultButton: UIButton!
    
    var arr: [Int] = []
    var range: Int = 0
    var randomInt = 0
    var selectedNumber = 0
    var tryCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (16 * 2) - (8 * 5)) / 6
        
        arr.append(contentsOf: (1...range))
        randomInt = arr.randomElement()!
        print(randomInt)
        
        listCollectionView.backgroundColor = .clear
        let xib = UINib(nibName: "UpDownCollectionViewCell", bundle: nil)
        listCollectionView.register(xib, forCellWithReuseIdentifier: "UpDownCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        
        listCollectionView.collectionViewLayout = layout
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        buttonEnabled(arr.contains(selectedNumber))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpDownCollectionViewCell", for: indexPath) as! UpDownCollectionViewCell
        cell.backgroundColor = .clear
        cell.numberLabel.text = "\(arr[indexPath.row])"
        cell.numberLabel.backgroundColor = .white
        cell.numberLabel.textColor = .black
        if arr[indexPath.row] == selectedNumber {
            cell.numberLabel.backgroundColor = .black
            cell.numberLabel.textColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedNumber = arr[indexPath.row]
        collectionView.reloadData()
        buttonEnabled(true)
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        if selectedNumber > randomInt {
            tryCount += 1
            countLabel.text = "시도횟수: \(tryCount)"
            arr = arr.filter {$0 < selectedNumber}
            titleLabel.text = "DOWN"
        } else if selectedNumber < randomInt {
            tryCount += 1
            countLabel.text = "시도횟수: \(tryCount)"
            arr = arr.filter {$0 > selectedNumber}
            titleLabel.text = "UP"
        } else {
            titleLabel.text = "GOOD!"
            resultButton.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
            resultButton.setTitle("처음으로", for: .normal)
            return
        }
        buttonEnabled(false)
        listCollectionView.reloadData()
    }
    
    func buttonEnabled(_ enabled: Bool) {
        resultButton.setTitle("결과 확인하기", for: .normal)
        if enabled {
            resultButton.isEnabled = true
            resultButton.backgroundColor = .black
            resultButton.setTitleColor(.white, for: .normal)
        } else {
            resultButton.isEnabled = false
            resultButton.backgroundColor = .gray
            resultButton.setTitleColor(.white, for: .disabled)
        }
    }
    
    @objc func moveBack() {
        navigationController?.popViewController(animated: true)
    }
}
