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
        navigationItem.title = "인기 도시"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backButtonDismiss))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func configureLabel() {
        mainLabel.text = str
        mainLabel.font = .systemFont(ofSize: 25, weight: .bold)
    }
    
    @objc func backButtonDismiss() {
        dismiss(animated: true)
    }
}
