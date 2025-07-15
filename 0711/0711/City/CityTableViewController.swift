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
    
    var cities = CityInfo().city

    override func viewDidLoad() {
        super.viewDidLoad()
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
        switch sender.selectedSegmentIndex {
        case 0:
            cities = CityInfo().city
            tableView.reloadData()
        case 1:
            cities = CityInfo().city.filter { $0.domestic_travel == true }
            tableView.reloadData()
        case 2:
            cities = CityInfo().city.filter { $0.domestic_travel == false }
            tableView.reloadData()
        default:
            break
        }
    }
}
