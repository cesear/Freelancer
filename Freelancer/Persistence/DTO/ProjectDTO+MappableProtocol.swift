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
        model.status = status
        model.timeSpent = timeSpent
        return model
    }
    
    static func mapFromPersistenceObject(_ project: Project) -> ProjectDTO {
        return ProjectDTO(name: project.name, status: project.status, timeSpent: project.timeSpent)
    }

}
