//
//  BaseView.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/30/25.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable) // 버전대응할 떄 사용하는건데 (ios, 18) 코드처럼 사용하면 사용하지 않겟다 !~
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        
    }
    
}
