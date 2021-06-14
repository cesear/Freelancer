//
//  Project.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation
import RealmSwift

class Project: Object{
    @objc dynamic var name = ""
    @objc dynamic var completed: Bool = false
    let sessions = List<Session>()
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(_ name: String, completed: Bool) {
        self.init()
        self.name = name
        self.completed = completed
    }
}

