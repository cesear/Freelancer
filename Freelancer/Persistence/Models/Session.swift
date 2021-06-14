//
//  Session.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import Foundation
import RealmSwift

class Session: Object{
    @objc dynamic var sessionLength: Double = 0.0
    @objc dynamic var sessionDescription = ""
    @objc dynamic var sessionId = ""

    override static func primaryKey() -> String? {
        return "sessionId"
      }
    let ofProject = LinkingObjects(fromType: Project.self,
                                property: "sessions")
    
    convenience init(_ sessionLength: Double, _ sessionDescription: String) {
        self.init()
        self.sessionLength = sessionLength
        self.sessionDescription = sessionDescription
    }
}
