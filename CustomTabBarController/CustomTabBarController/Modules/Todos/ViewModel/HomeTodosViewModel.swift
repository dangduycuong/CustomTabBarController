//
//  HomeTodosViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation


class HomeTodosViewModel {
    var listTodo = [TodoModel]()
    
    func getListTodo(completed: @escaping(() -> Void)) {
        DataManager.shared.getListTodo( { todos in
            self.listTodo = todos
            completed()
        })
    }
}
