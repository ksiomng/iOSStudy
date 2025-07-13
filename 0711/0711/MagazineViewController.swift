//
//  TravelTableViewController.swift
//  0711
//
//  Created by Song Kim on 7/13/25.
//

import UIKit
import Kingfisher

class MagazineViewController: UITableViewController {
    private let list = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "magazineCell", for: indexPath) as! MagazineTableViewCell
        let travel = list[indexPath.row]
        cell.titleImageView.kf.setImage(with: URL(string: travel.photo_image))
        cell.titleLabel.text = travel.title
        cell.subtitleLabel.text = travel.subtitle
        cell.dateLabel.text = travel.date
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        450
    }
}
