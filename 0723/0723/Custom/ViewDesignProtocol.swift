//
//  ViewDesignProtocol.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import Foundation

protocol ViewDesignProtocol: AnyObject {
    func configureHierarchy() // addSubView
    func configureLayout() // layout
    func configureView() // 뷰 그리기
}
