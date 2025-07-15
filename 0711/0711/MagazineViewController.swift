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
        cell.dateLabel.text = dateFormatting(travel.date)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func dateFormatting(_ rawDate: String) -> String {
        let fullDateString = "20" + rawDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: fullDateString)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yy년 MM월 dd일"
        let formatted = outputFormatter.string(from: date!)
        
        return formatted
    }
}
