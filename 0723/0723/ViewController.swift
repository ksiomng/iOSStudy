//
//  ViewController.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let lottoButton = {
        let button = SongButton(title: "로또화면으로")
        return button
    }()
    
    let movieListButton = {
        let button = SongButton(title: "박스오피스화면으로")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension ViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(lottoButton)
        view.addSubview(movieListButton)
    }
    
    func configureLayout() {
        lottoButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(100)
        }
        
        movieListButton.snp.makeConstraints { make in
            make.top.equalTo(lottoButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    func configureView() {
        view.backgroundColor = .systemGray6
        lottoButton.addTarget(self, action: #selector(goLottoView), for: .touchUpInside)
        movieListButton.addTarget(self, action: #selector(goListView), for: .touchUpInside)
    }
}

extension ViewController {
    @objc func goLottoView() {
        let vc = LottoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goListView() {
        let vc = MovieListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
