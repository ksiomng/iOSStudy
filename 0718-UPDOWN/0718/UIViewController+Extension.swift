//
//  UIViewController+Extension.swift
//  0718
//
//  Created by Song Kim on 7/18/25.
//

import UIKit

extension UIViewController {
    func showAlert(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let check = UIAlertAction(title: "확인", style: .destructive)
        alert.addAction(check)
        present(alert, animated: true)
    }
}
