//
//  UpDownViewController.swift
//  0718
//
//  Created by Song Kim on 7/17/25.
//

import UIKit

class UpDownViewController: UIViewController {
    
    @IBOutlet var listCollectionView: UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var selelctedNumberLabel: UILabel!
    
    var numList: [Int] = []
    var range: Int = 0
    var randomInt = 0
    var selectedNumber = 0
    var tryCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartGame()
        setCollectionViewLayout(cellCount: 5)
    }
    
    private func setStartGame() {
        numList.append(contentsOf: (1...range))
        randomInt = numList.randomElement()!
        print(randomInt)
        
        listCollectionView.backgroundColor = .clear
        let xib = UINib(nibName: "UpDownCollectionViewCell", bundle: nil)
        listCollectionView.register(xib, forCellWithReuseIdentifier: "UpDownCollectionViewCell")
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        buttonEnabled()
    }
    
    private func setCollectionViewLayout(cellCount: CGFloat) {
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (16 * 2) - (8 * (cellCount - 1))) / cellCount
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        
        listCollectionView.collectionViewLayout = layout
    }
    
    @IBAction private func resultButtonClicked(_ sender: UIButton) {
        if selectedNumber > randomInt {
            plusTryCount()
            numList = numList.filter {$0 < selectedNumber}
            titleLabel.text = "DOWN"
        } else if selectedNumber < randomInt {
            plusTryCount()
            numList = numList.filter {$0 > selectedNumber}
            titleLabel.text = "UP"
        } else {
            titleLabel.text = "GOOD!"
            resultButton.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
            resultButton.setTitle("처음으로", for: .normal)
            resultButton.backgroundColor = .systemBlue
            return
        }
        buttonEnabled()
        selelctedNumberLabel.text = "이전에 선택한 숫자 \(selectedNumber)"
        listCollectionView.reloadData()
    }
    
    @objc private func moveBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func plusTryCount() {
        tryCount += 1
        countLabel.text = "시도횟수: \(tryCount)"
    }
    
    private func buttonEnabled() {
        resultButton.setTitle("결과 확인하기", for: .normal)
        if numList.contains(selectedNumber) {
            resultButton.isEnabled = true
            resultButton.backgroundColor = .black
            resultButton.setTitleColor(.white, for: .normal)
        } else {
            resultButton.isEnabled = false
            resultButton.backgroundColor = .gray
            resultButton.setTitleColor(.white, for: .disabled)
        }
    }
}

// collectionView
extension UpDownViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpDownCollectionViewCell", for: indexPath) as! UpDownCollectionViewCell

        cell.configureData(selectedNumber: selectedNumber, numListInt: numList[indexPath.row])
        
        DispatchQueue.main.async {
            cell.numberLabel.radius(size: cell.numberLabel.frame.width / 2)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedNumber != randomInt {
            selectedNumber = numList[indexPath.row]
            collectionView.reloadData()
            buttonEnabled()
        }
    }
}
