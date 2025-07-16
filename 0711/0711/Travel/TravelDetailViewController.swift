//
//  TravelDetailViewController.swift
//  0711
//
//  Created by Song Kim on 7/15/25.
//

import UIKit
import Kingfisher

class TravelDetailViewController: UIViewController {
    var image = ""
    var mainTitle = ""
    var subTitle = ""
    
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        placeImageView.kf.setImage(with: URL(string: image))
        CornerRadius.radius(placeImageView, size: 10)
        
        mainLabel.text = mainTitle
        mainLabel.font = .systemFont(ofSize: 40, weight: .bold)
        
        subLabel.text = subTitle
        subLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        
        backButton.setTitle("다른 관광지 보러 가기", for: .normal)
        CornerRadius.radius(backButton, size: 25)
        
        navigationTitle("관광지 화면")
    }
    
    @IBAction func dismissNavigation(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
