//
//  Design.swift
//  SeSAC7Week1Remind
//
//  Created by Song Kim on 7/7/25.
//

import UIKit

//open class Design {
//    func radiusUI(_ view: UIView) {
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 1.5
//        view.layer.borderColor = UIColor.black.cgColor
//    }
//}

//public class Design {
//    func radiusUI(_ view: UIView) {
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 1.5
//        view.layer.borderColor = UIColor.black.cgColor
//    }
//}

//class Design {
//    func radiusUI(_ view: UIView) {
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 1.5
//        view.layer.borderColor = UIColor.black.cgColor
//    }
//}

//class Design {
//    public func radiusUI(_ view: UIView) {
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 1.5
//        view.layer.borderColor = UIColor.black.cgColor
//    }
//}

class Design { // static은 타입 속성 지정자 - 인스턴스 생성없이 접근가능(정적 메서드, 타입 메서드)
    static func radiusUI(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
    }
    // 뷰에서 사용할 때 Design.radiusUI()
}

// class안에 함수를 넣어서 사용하는게 좋을까 ? 그냥 함수만 두는게 좋을까 ?
