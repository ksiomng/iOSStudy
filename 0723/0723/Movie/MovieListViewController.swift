//
//  ListViewController.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    
    let inputTextField = UITextField()
    let searchButton = UIButton(type: .system)
    let tableView = UITableView()
    
    var movies: [Movie] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @objc private func searchTapped() {
        reloadRandomMovies()
        view.endEditing(true)
    }
    
    private func reloadRandomMovies() {
        movies = Array(MovieInfo.movies.shuffled().prefix(10))
        inputTextField.text = ""
        tableView.reloadData()
    }
}

extension MovieListViewController: ViewDesignProtocol {
    
    func configureHierarchy() {
        view.addSubview(inputTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(searchButton.snp.leading).offset(-8)
            make.height.equalTo(40)
        }

        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(inputTextField.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        reloadRandomMovies()
        
        inputTextField.placeholder = "아무거나 입력 후 엔터 or 버튼"
        inputTextField.borderStyle = .roundedRect
        inputTextField.returnKeyType = .done
        inputTextField.delegate = self
        
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = .darkGray
        searchButton.layer.cornerRadius = 6
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
    }
}

extension MovieListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        reloadRandomMovies()
        view.endEditing(true)
        textField.text = ""
        return true
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.movieCell.rawValue, for: indexPath) as! MovieCell
        cell.configure(index: indexPath.row, movie: movie)
        return cell
    }
}
