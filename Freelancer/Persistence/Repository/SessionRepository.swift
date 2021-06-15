//
//  SessionRepository.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import Foundation
import RealmSwift

class SessionRepository: Repository<Session>{
    
    func exist(_ sessionDTO: SessiontDTO ) -> Bool {
        return super.exist(Session.self, object: sessionDTO.mapToPersistenceObject())
    }
    
    func saveSession(_ sessionDTO: SessiontDTO) {
        do { try super.save(object: sessionDTO.mapToPersistenceObject()) }
        catch { print(error.localizedDescription) }
    }
    
    func getAllSessions(on sort: Sorted? = nil )->[SessiontDTO] {
        return super.fetch(Session.self, predicate: nil, sorted: sort).map({ SessiontDTO.mapFromPersistenceObject($0 as! Session) })
    }
    
    func getAll(on sort: Sorted? = nil )->Results<Object>? {
        return super.getAll(Session.self)
    }
    
    func delete(_ sessiontDTO: SessiontDTO, predicate: NSPredicate){
        do { try super.delete(Session.self, object: sessiontDTO.mapToPersistenceObject(), predicate: predicate) }
        catch { print(error.localizedDescription) }
    }
    
    func deleteAll(){
        do { try super.deleteAll(Session.self) }
        catch { print(error.localizedDescription) }
    }
}
