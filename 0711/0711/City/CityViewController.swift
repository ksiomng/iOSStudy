//
//  CityViewController.swift
//  0711
//
//  Created by Song Kim on 7/16/25.
//

import UIKit

class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var domesticTravelSegment: UISegmentedControl!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cityTableView: UITableView!
    
    var cities = [City]()
    var pointColorLowerString = ""
    var pointColorUpperString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource  = self
        
        filterCityList(domesticTravelSegment.selectedSegmentIndex)
        let xib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        cityTableView.register(xib, forCellReuseIdentifier: CityTableViewCell.identifier)
        cityTableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier) as! CityTableViewCell
        cell.backgroundImageView.kf.setImage(with: URL(string: city.city_image))
        cell.titleLabel.text = "\(city.city_name) | \(city.city_english_name)"
        cell.cityListLabel.text = "  " + city.city_explain
        
        cell.titleLabel.asFontColor(targetStringList: [pointColorLowerString, pointColorUpperString], color: .red)
        cell.cityListLabel.asFontColor(targetStringList: [pointColorLowerString, pointColorUpperString], color: .red)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    // segment 바뀔때
    @IBAction func segmentedChange(_ sender: UISegmentedControl) {
        searchTextField.text = ""
        pointColorLowerString = ""
        pointColorUpperString = ""
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
    
    // 실시간
    @IBAction func editSearchCity(_ sender: UITextField) {
        if let text = sender.text {
            searchFilterCityList(text)
        }
    }
    
    // 엔터눌렀을때
    @IBAction func searchCity(_ sender: UITextField) {
        if let text = sender.text {
            searchFilterCityList(text)
        }
    }
    
    // 첫번째 글자만 대문자
    func capitalizeFirstLetter(of string: String) -> String {
        guard let firstLetter = string.first else {
            return string
        }
        let firstLetterCapitalized = String(firstLetter).uppercased()
        let remainingLetters = string.dropFirst().lowercased()
        return firstLetterCapitalized + remainingLetters
    }
    
    func filterCityList(_ idx: Int) {
        if idx == 0 {
            cities = CityInfo().city
        } else if idx == 1 {
            cities = CityInfo().city.filter { $0.domestic_travel == true }
        } else if idx == 2 {
            cities = CityInfo().city.filter { $0.domestic_travel == false }
        }
        cityTableView.reloadData()
    }
    
    func searchFilterCityList(_ text: String) {
        filterCityList(domesticTravelSegment.selectedSegmentIndex)
        if text != "" {
            cities = cities.filter { $0.city_name.contains(text) || $0.city_english_name.lowercased().contains(text.lowercased()) || $0.city_explain.contains(text)
            }
            pointColorLowerString = text.lowercased()
            pointColorUpperString =  capitalizeFirstLetter(of: text)
        } else {
            pointColorLowerString = ""
            pointColorUpperString = ""
        }
        cityTableView.reloadData()
    }
}
