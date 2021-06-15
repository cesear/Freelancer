//
//  DBManager+DataManager.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//
import Foundation
import RealmSwift

extension DBManager: DataManager {
    
    func delete<T>(_ model:  T.Type, object: Storable, predicate: NSPredicate?) throws {
        guard let realm = realm,  let model = model as? Object.Type, let object = object as? Object else { throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
        try realm.write {
            if let objectToDelete = realm.object(ofType: model, forPrimaryKey: object.value(forKey: model.primaryKey() ?? "")){
                realm.delete(objectToDelete)
            }
        }
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> [Storable] where T : Storable {
        var result = [Storable]()
        guard let realm = realm, let model = model as? Object.Type else { return result}
        var objects = realm.objects(model)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        for obj in objects.compactMap({$0 as? T}) {
            result.append(obj)
        }
        return result
    }
    
    func save(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else { throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
        try realm.write {
            realm.add(object)
        }
    }
    
    func exist<T>(_ model:  T.Type, object: Storable) -> Bool {
        guard let realm = realm, let model = model as? Object.Type, let object = object as? Object else { return false }
        return (realm.object(ofType: model, forPrimaryKey: object.value(forKey: model.primaryKey() ?? "")) != nil)
    }
    
    func deleteAll<T>(_ model: T.Type) throws where T : Storable {
        guard let realm = realm, let model = model as? Object.Type else { throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
        try realm.write {
            let objects = realm.objects(model)
            for object in objects {
                realm.delete(object)
            }
        }
    }
    
    func getAll<T>(_ model:  T.Type) -> Results<Object>? where T : Storable{
        guard let realm = realm, let model = model as? Object.Type else { return nil}
        return realm.objects(model)   
    }
    
    func update(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            realm.add(object,update: .modified)
        }
    }
}
