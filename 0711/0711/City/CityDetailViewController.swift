//
//  CityDetailViewController.swift
//  0711
//
//  Created by Song Kim on 7/16/25.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    var city: City = City(city_name: "", city_english_name: "", city_explain: "", city_image: "", domestic_travel: false)
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var domesticLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        navigationTitle("\(city.city_name) \(city.city_english_name)")
        
        cityImageView.kf.setImage(with: URL(string: city.city_image))
        CornerRadius.radiusTwo(cityImageView, size: 20)
        
        domesticLabel.text = city.domestic_travel ? "(국내)" : "(해외)"
        domesticLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        explainLabel.text = city.city_explain
    }
}
