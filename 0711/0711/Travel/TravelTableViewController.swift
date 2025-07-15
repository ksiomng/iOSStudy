//
//  TravelTableViewController.swift
//  0711
//
//  Created by Song Kim on 7/13/25.
//

import UIKit

class TravelTableViewController: UITableViewController {
    
    private var list = TravelInfo().travel
    
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
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell") as! TravelTableViewCell
            cell.titleLabel.text = travel.title
            cell.descriptionLabel.text = travel.description
            cell.placeImageView.kf.setImage(with: URL(string: travel.travel_image!))
            cell.fillStarColor(travel.grade!)
            cell.starAndSaveLabel.text = "(\(travel.grade!)) * 저장 \(travel.save!)"
            cell.checkLiked(like: travel.like!)
            cell.likeButton.tag = indexPath.row
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if list[indexPath.row].ad {
            return 140
        } else {
            return 148
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let travel = list[indexPath.row]
        
        if travel.ad {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ADDetailViewController") as! ADDetailViewController
            vc.str = travel.title
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TravelDetailViewController") as! TravelDetailViewController
            vc.image = travel.travel_image!
            vc.mainTitle = travel.title
            vc.subTitle = travel.description!
            let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            backButton.tintColor = .black
            navigationItem.backBarButtonItem = backButton
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func toggleLike(_ sender: UIButton) {
        list[sender.tag].like!.toggle()
        tableView.reloadData()
    }
}
