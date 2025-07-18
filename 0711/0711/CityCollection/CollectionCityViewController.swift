//
//  CollectionCityViewController.swift
//  0711
//
//  Created by Song Kim on 7/17/25.
//

import UIKit

class CollectionCityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    var cities = CityInfo().city
    
    var pointColorLowerString = ""
    
    @IBOutlet var cityCollectionView: UICollectionView!
    @IBOutlet var domesticTravelSegment: UISegmentedControl!
    @IBOutlet var citySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "CityCollectionViewCell", bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: "CityCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (16 * 2) - (16)) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth+100)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16 // 행
        layout.minimumInteritemSpacing = 16
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
        
        if pointColorLowerString != "" {
            cell.cityNameLabel.asFontColor(targetStringList: pointColorLowerString, color: .red)
            cell.subLabel.asFontColor(targetStringList: pointColorLowerString, color: .red)
        }
        
        DispatchQueue.main.async {
            CornerRadius.radius(cell.cityImageView, size: (cell.cityImageView.frame.width/2))
        }
        
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
        citySearchBar.text = ""
    }
    
    func filterCityList(_ idx: Int) {
        pointColorLowerString = ""
        if idx == 0 {
            cities = CityInfo().city
        } else if idx == 1 {
            cities = CityInfo().city.filter { $0.domestic_travel == true }
        } else if idx == 2 {
            cities = CityInfo().city.filter { $0.domestic_travel == false }
        }
        cityCollectionView.reloadData()
    }
    
    func searchFilterCityList(_ text: String) {
        filterCityList(domesticTravelSegment.selectedSegmentIndex)
        if text != "" {
            cities = cities.filter { $0.city_name.contains(text) || $0.city_english_name.lowercased().contains(text.lowercased()) || $0.city_explain.contains(text)
            }
            pointColorLowerString = text.lowercased()
        } else {
            pointColorLowerString = ""
        }
        cityCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            searchFilterCityList(text)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchFilterCityList(text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterCityList(domesticTravelSegment.selectedSegmentIndex)
    }
}
