//
//  DataManager.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation
import RealmSwift
protocol DataManager {
    func save(object: Storable) throws
    func exist<T: Storable>(_ model: T.Type, object: Storable) -> Bool
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> [Storable]
    func delete<T: Storable>(_ model: T.Type, object: Storable, predicate: NSPredicate?) throws
    func deleteAll<T: Storable>(_ model: T.Type) throws
    func getAll<T: Storable>(_ model: T.Type) -> Results<Object>?
    func update(object: Storable) throws
}
