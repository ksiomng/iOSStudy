//
//  UIViewController+Extension.swift
//  0711
//
//  Created by Song Kim on 7/16/25.
//

import UIKit

extension UIViewController {
    func navigationTitle(_ str: String) {
        navigationItem.title = str
    }
    
    func simpleBackButtonStyle() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
    }
}
