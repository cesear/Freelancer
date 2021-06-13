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
    @objc dynamic var status: Bool = false
    @objc dynamic var timeSpent: Int = 0

    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(_ name: String, _ timeSpent: Int, status: Bool) {
        self.init()
        self.name = name
        self.timeSpent = timeSpent
        self.status = status
    }
}

