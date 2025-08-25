//
//  UIViewController+Extension.swift
//  Tama
//
//  Created by Song Kim on 8/24/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, msg: String, ok: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let no = UIAlertAction(title: "아냐!", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "웅", style: .default) { _ in
            ok?()
        }
        
        alert.addAction(no)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
}
