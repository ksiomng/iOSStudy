//
//  TravelTableViewController.swift
//  0711
//
//  Created by Song Kim on 7/13/25.
//

import UIKit

class TravelTableViewController: UITableViewController {
    private let list = TravelInfo().travel
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = list[indexPath.row]
        if travel.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "adTableCell") as! ADTableViewCell
            cell.contentLabel.text = travel.title
            cell.backgroundColorView.backgroundColor = UIColor.lightPink
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell") as! TravelTableViewCell
            cell.titleLabel.text = travel.title
            cell.descriptionLabel.text = travel.description
            cell.placeImageView.kf.setImage(with: URL(string: travel.travel_image!))
            for i in 0..<Int(travel.grade ?? 1) {
                cell.fiveStarView[i].tintColor = .yellow
            }
            cell.starAndSaveLabel.text = "(\(travel.grade!)) * 저장 \(travel.save!)"
            if travel.like! {
                cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if list[indexPath.row].ad {
            return 144
        } else {
            return 148
        }
    }
}
