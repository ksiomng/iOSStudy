//
//  UpDownCollectionViewCell.swift
//  0718
//
//  Created by Song Kim on 7/17/25.
//

import UIKit

class UpDownCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        backgroundColor = .clear
    }
    
    func configureData(selectedNumber: Int, numListInt: Int) {
        numberLabel.text = "\(numListInt)"
        
        if numListInt == selectedNumber {
            numberLabel.backgroundColor = .black
            numberLabel.textColor = .white
        } else {
            numberLabel.backgroundColor = .white
            numberLabel.textColor = .black
        }
    }
}
