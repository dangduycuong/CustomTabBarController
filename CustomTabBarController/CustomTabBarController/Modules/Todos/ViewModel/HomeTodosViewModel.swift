//
//  HomeTodosViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation
import RealmSwift

class HomeTodosViewModel {
    
    lazy var realm = try! Realm()
    var listTodo: Results<TodoModel> {
        get {
            let items = realm.objects(TodoModel.self)
            displayTodos = items.toArray(ofType: TodoModel.self)
            return items
        }
    }
    
    var displayTodos = [TodoModel]()
    
    var searchText: String? = "" {
        didSet {
            if searchText == "" {
                displayTodos = listTodo.toArray(ofType: TodoModel.self)
            } else {
                guard let keyWord = searchText?.lowercased().unaccent() else { return }
                displayTodos = listTodo.filter { (todo: TodoModel) in
                    let title = todo.titleTodo.lowercased().unaccent()
                    let description = todo.descriptionTodo.lowercased().unaccent()
                    if title.range(of: keyWord) != nil {
                        return true
                    }
                    if description.range(of: keyWord) != nil {
                        return true
                    }
                    return false
                }
            }
        }
    }
    
    func getListTodo(completed: @escaping(() -> Void)) {
        //        DataManager.shared.getListTodo( { todos in
        //            self.listTodo = todos
        //            completed()
        //        })
    }
}
