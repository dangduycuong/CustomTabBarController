//
//  TodoModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation
import RealmSwift

class TodoModel: Object {
    @objc dynamic var idTodo: String = ""
    @objc dynamic var titleTodo: String = ""
    @objc dynamic var descriptionTodo: String = ""
    @objc dynamic var completed: Bool = true
    
    
    override static func primaryKey() -> String? {
        return "idTodo"
    }

}
