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
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: 25 , y: 150, width: view.frame.size.width - 50, height: 40))
        toastLabel.backgroundColor = UIColor.blue
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
