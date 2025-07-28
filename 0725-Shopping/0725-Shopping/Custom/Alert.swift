//
//  Alert.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/28/25.
//

import UIKit

extension UIViewController {
    func showAlert(message: String, title: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
