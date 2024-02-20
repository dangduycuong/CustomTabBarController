//
//  TodoInfoViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation


class TodoInfoViewModel {
    
    func createTodo(titleTodo: String, descriptionTodo: String, isCompleted: Bool) {
        let todo = TodoModel()
        todo.idTodo = UUID().uuidString
        todo.titleTodo = titleTodo
        todo.descriptionTodo = descriptionTodo
        todo.completed = isCompleted
        
        DataManager.shared.createTodo(todo)
    }
}
