//
//  TravelTalkMainViewController.swift
//  0718-Talk
//
//  Created by Song Kim on 7/18/25.
//

import UIKit

class TravelTalkMainViewController: UIViewController {

    @IBOutlet var searchBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarView.layer.cornerRadius = 8
        searchBarView.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
