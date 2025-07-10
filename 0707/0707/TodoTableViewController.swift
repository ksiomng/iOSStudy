//
//  TodoTableViewController.swift
//  0707
//
//  Created by Song Kim on 7/10/25.
//

import UIKit

struct Todo {
    var checked: Bool = false
    var content: String
    var favorite: Bool = false
}

class TodoTableViewController: UITableViewController {
    var todoList: [Todo] = [
        Todo(checked: true, content: "단백질 챙기기"),
        Todo(content: "운동하기", favorite: true),
        Todo(content: "과자 사오기"),
        Todo(content: "고양이 밥주기")
    ]
    @IBOutlet var addTodoTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        let todo = todoList[indexPath.row]
        
        let checkImage = todo.checked ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: checkImage), for: .normal)
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(toggleCheck(_:)), for: .touchUpInside)
        
        cell.todoTextLabel.text = todo.content
        
        let favoriteImage = todo.favorite ? "star.fill" : "star"
        cell.favoriteButton.setImage(UIImage(systemName: favoriteImage), for: .normal)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(toggleFavorite(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func toggleCheck(_ sender: UIButton) {
        let index = sender.tag
        todoList[index].checked.toggle()
        tableView.reloadData()
    }
    
    @objc func toggleFavorite(_ sender: UIButton) {
        let index = sender.tag
        todoList[index].favorite.toggle()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    @IBAction func addTodoButtonClicked(_ sender: UIButton) {
        if addTodoTextField.text == "" {
            print("추가할목록을 작성해주세요")
        } else {
            let todo = Todo(content: addTodoTextField.text!)
            todoList.append(todo)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
