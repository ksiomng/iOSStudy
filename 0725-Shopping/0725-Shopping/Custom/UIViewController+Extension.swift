//
//  UIViewController+Extension.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/28/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(title: String? = nil, message: String, ok: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            ok()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
