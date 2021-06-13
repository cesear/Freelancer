//
//  DataManager.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation

protocol DataManager{
    func save(object: Storable) throws
    func exist<T: Storable>(_ model: T.Type, object: Storable)->Bool
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) ->[Storable]
    func delete<T: Storable>(_ model: T.Type, object: Storable, predicate: NSPredicate?) throws
}

