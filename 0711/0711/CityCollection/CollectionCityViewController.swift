//
//  CollectionCityViewController.swift
//  0711
//
//  Created by Song Kim on 7/17/25.
//

import UIKit

class CollectionCityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var cities = CityInfo().city
    
    @IBOutlet var cityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "CityCollectionViewCell", bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: "CityCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (10 * 2) - (10 * 3)) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth+100)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        cityCollectionView.collectionViewLayout = layout
        
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let city = cities[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionViewCell", for: indexPath) as! CityCollectionViewCell
        cell.cityImageView.kf.setImage(with: URL(string: city.city_image))
        cell.cityNameLabel.text = "\(city.city_name) | \(city.city_english_name)"
        cell.subLabel.text = city.city_explain
        return cell
    }
    
    @IBAction func segmentedChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filterCityList(0)
        case 1:
            filterCityList(1)
        case 2:
            filterCityList(2)
        default:
            break
        }
    }
    
    func filterCityList(_ idx: Int) {
        if idx == 0 {
            cities = CityInfo().city
        } else if idx == 1 {
            cities = CityInfo().city.filter { $0.domestic_travel == true }
        } else if idx == 2 {
            cities = CityInfo().city.filter { $0.domestic_travel == false }
        }
        cityCollectionView.reloadData()
    }
}
