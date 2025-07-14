//
//  TodoTableViewController.swift
//  0707
//
//  Created by Song Kim on 7/10/25.
//

/// 방법1 id값을 줘서
/// 방법2 배열을 두개로 나눠서 <------>
/// 방법3 계산하는 이상한 방법으로

import UIKit

struct Todo {
    var checked: Bool = false
    var content: String
    var favorite: Bool = false
}

class TodoTableViewController: UITableViewController {
    var todoList: [Todo] = [
        Todo(content: "운동하기", favorite: true),
        Todo(content: "과자 사오기"),
        Todo(content: "고양이 밥주기"),
        Todo(checked: true, content: "단백질 챙기기")
    ]
    
    @IBOutlet var addTodoTextField: UITextField!
    
    var incompleteTodos: [Todo] {
        return todoList.filter { !$0.checked }
    }
    var completeTodos: [Todo] {
        return todoList.filter { $0.checked }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? incompleteTodos.count : completeTodos.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "미완료" : "완료"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        
        let currentTodo = indexPath.section == 0 ? incompleteTodos[indexPath.row] : completeTodos[indexPath.row]
        
        let checkImage = currentTodo.checked ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: checkImage), for: .normal)
        cell.todoTextLabel.text = currentTodo.content
        
        let favoriteImage = currentTodo.favorite ? "star.fill" : "star"
        cell.favoriteButton.setImage(UIImage(systemName: favoriteImage), for: .normal)
        
        cell.checkboxButton.tag = indexForTodo(currentTodo)
        cell.checkboxButton.addTarget(self, action: #selector(toggleCheck(_:)), for: .touchUpInside)
        
        cell.favoriteButton.tag = indexForTodo(currentTodo)
        cell.favoriteButton.addTarget(self, action: #selector(toggleFavorite(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func indexForTodo(_ todo: Todo) -> Int {
        return todoList.firstIndex(where: { $0.content == todo.content && $0.checked == todo.checked })!
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
    
    @IBAction func addTodoButtonClicked(_ sender: UIButton) {
        guard let text = addTodoTextField.text, !text.isEmpty else {
            print("추가할 목록을 작성해주세요")
            return
        }
        
        let todo = Todo(content: text)
        todoList.append(todo)
        addTodoTextField.text = ""
        tableView.reloadData()
    }
    
    // 삭제 기능도 섹션 기반으로
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoToDelete = indexPath.section == 0 ? incompleteTodos[indexPath.row] : completeTodos[indexPath.row]
            if let index = todoList.firstIndex(where: { $0.content == todoToDelete.content && $0.checked == todoToDelete.checked }) {
                todoList.remove(at: index)
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
