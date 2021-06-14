//
//  ProjectDTO+MappableProtocol.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation
//MARK: - MappableProtocol Implementation
extension ProjectDTO: MappableProtocol{
    
    func mapToPersistenceObject() -> Project {
        let model = Project()
        model.name = name
        model.completed = completed
        model.sessions.append(objectsIn: sessions.map { $0.mapToPersistenceObject() })
        return model
    }
    
    static func mapFromPersistenceObject(_ project: Project) -> ProjectDTO {
        var sessions = [SessiontDTO]()
        project.sessions.forEach { (session) in
            sessions.append(SessiontDTO.mapFromPersistenceObject(session))
        }
        return ProjectDTO(name: project.name, completed: project.completed, sessions: sessions)
    }

}
