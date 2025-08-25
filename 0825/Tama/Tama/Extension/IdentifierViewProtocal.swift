//
//  UICollectionView+Extension.swift
//  Tama
//
//  Created by Song Kim on 8/24/25.
//

import UIKit

protocol IdentifierViewProtocal {
    static var identifier: String {get}
}

extension UICollectionViewCell: IdentifierViewProtocal {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: IdentifierViewProtocal {
    static var identifier: String {
        return String(describing: self)
    }
}
