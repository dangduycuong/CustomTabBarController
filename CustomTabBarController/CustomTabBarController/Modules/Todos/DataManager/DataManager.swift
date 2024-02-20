//
//  DataManager.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager: NSObject {
    static let shared = DataManager()
    let realm = try! Realm()
    
    func createTodo(_ todoAdd: TodoModel) {
        let todo = TodoModel()
        
        todo.idTodo = todoAdd.idTodo
        todo.titleTodo = todoAdd.titleTodo
        todo.descriptionTodo = todoAdd.descriptionTodo
        todo.completed = todoAdd.completed
        
        try! realm.write {
            realm.add(todo)
        }
    }
    
    func getListTodo(_ completionHandler: @escaping ([TodoModel]) -> Void ) {
        var listDpcumentType = [TodoModel]()
        let documentTypes = realm.objects(TodoModel.self)
        for item in documentTypes {
            listDpcumentType.append(item)
        }
        completionHandler(listDpcumentType)
    }
    
    func removeTodo(idTodo: String) -> Bool {
        guard let todo = realm.objects(TodoModel.self).filter({$0.idTodo == idTodo}).first else { return false }
        try! realm.write {
            realm.delete(todo)
        }
        return true
    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
