//
//  CityTableViewController.swift
//  0711
//
//  Created by Song Kim on 7/15/25.
//

import UIKit
import Kingfisher

class CityTableViewController: UITableViewController {
    @IBOutlet var domesticTravelSegment: UISegmentedControl!
    @IBOutlet var searchTextField: UITextField!
    
    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterCityList(domesticTravelSegment.selectedSegmentIndex)
        let xib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier) as! CityTableViewCell
        cell.backgroundImageView.kf.setImage(with: URL(string: city.city_image))
        cell.titleLabel.text = "\(city.city_name) | \(city.city_english_name)"
        cell.cityListLabel.text = "  " + city.city_explain
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    @IBAction func segmentedChange(_ sender: UISegmentedControl) {
        searchTextField.text = ""
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
        tableView.reloadData()
    }
    
    func searchFilterCityList(_ text: String) {
        filterCityList(domesticTravelSegment.selectedSegmentIndex)
        cities = cities.filter { $0.city_name.contains(text) || $0.city_english_name.lowercased().contains(text.lowercased()) || $0.city_explain.contains(text)
        }
        tableView.reloadData()
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
}
