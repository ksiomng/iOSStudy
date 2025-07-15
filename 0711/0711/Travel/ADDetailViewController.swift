//
//  ADDetailViewController.swift
//  0711
//
//  Created by Song Kim on 7/15/25.
//

import UIKit

class ADDetailViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    var str = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
    }
    
    func configureLabel() {
        mainLabel.text = str
        mainLabel.font = .systemFont(ofSize: 25, weight: .bold)
    }
    
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
