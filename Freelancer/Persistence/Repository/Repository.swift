//
//  Repository.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation
import RealmSwift

//MARK: - Repository
class Repository<T> {
    
    //MARK: - Stored Properties
    var dbManager : DataManager
    
    //MARK: - Init
    required init(dbManager : DataManager) {
        self.dbManager = dbManager
    }
    
    func save(object: Storable) throws {
        try dbManager.save(object: object)
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> [Storable] where T : Storable {
        dbManager.fetch(model, predicate: predicate, sorted: sorted)
    }
    
    func delete<T>(_ model: T.Type, object: Storable, predicate: NSPredicate?) throws where T : Storable{
        try dbManager.delete(model, object: object, predicate: predicate)
    }
    
    func exist<T>(_ model: T.Type, object: Storable)->Bool where T : Storable{
        return dbManager.exist(model, object: object)
    }
    
    func deleteAll<T>(_ model: T.Type) throws where T : Storable{
        try dbManager.deleteAll(model)
    }
    
    func getAll<T>(_ model: T.Type)-> Results<Object>? where T : Storable{
        return dbManager.getAll(model)
    }
    
    func update(object: Storable) throws {
        try dbManager.update(object: object)
    }
}
