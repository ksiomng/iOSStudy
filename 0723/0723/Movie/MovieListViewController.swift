//
//  ListViewController.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class MovieListViewController: UIViewController {
    
    lazy var inputTextField = {
        let textField = UITextField()
        textField.placeholder = "날짜로 검색해주세요 ex)20240929"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var searchButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var movies: [BoxOffice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @objc private func searchTapped() {
        dateLabel.text = SongDateFormatter.dateFormat(inputTextField.text!)
        fetchBoxOfficeData(date: inputTextField.text!)
        inputTextField.text = ""
        view.endEditing(true)
    }
    
    func fetchBoxOfficeData(date: String) {
        let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.movieKey)&targetDt=\(date)")!
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BoxOfficeResponse.self) { response in
                switch response.result {
                case .success(let res):
                    self.movies = res.boxOfficeResult.dailyBoxOfficeList
                    self.tableView.reloadData()
                    if res.boxOfficeResult.dailyBoxOfficeList.count == 0 {
                        self.dateLabel.text! += " (영화정보없음)"
                    }
                case .failure(let err):
                    self.dateLabel.text! += " (데이터 로딩실패)"
                    print(err)
                }
            }
    }
}

extension MovieListViewController: ViewDesignProtocol {
    
    func configureHierarchy() {
        view.addSubview(inputTextField)
        view.addSubview(searchButton)
        view.addSubview(dateLabel)
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
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        let yesterday = SongDateFormatter.yesterdayDateFormat()
        dateLabel.text = SongDateFormatter.dateFormat(yesterday)
        fetchBoxOfficeData(date: yesterday)
    }
}

extension MovieListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateLabel.text = SongDateFormatter.dateFormat(inputTextField.text!)
        fetchBoxOfficeData(date: inputTextField.text!)
        inputTextField.text = ""
        view.endEditing(true)
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
