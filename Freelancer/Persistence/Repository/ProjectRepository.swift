//
//  ProjectRepository.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation
class ProjectRepository: Repository<Project>{
    
    func exist(_ projectDTO: ProjectDTO ) -> Bool {
        return super.exist(Project.self, object: projectDTO.mapToPersistenceObject())
    }
    
    func saveProject(_ projectDTO: ProjectDTO) {
        do { try super.save(object: projectDTO.mapToPersistenceObject()) }
        catch { print(error.localizedDescription) }
    }
    
    func getAllProjects(on sort: Sorted? = nil )->[ProjectDTO] {
        return super.fetch(Project.self, predicate: nil, sorted: sort).map({ ProjectDTO.mapFromPersistenceObject($0 as! Project) })
    }

    func delete(_ projectDTO: ProjectDTO){
        do { try super.delete(Project.self, object: projectDTO.mapToPersistenceObject(), predicate: nil) }
        catch { print(error.localizedDescription) }
    }
    
    func deleteAll(){
        do { try super.deleteAll(Project.self) }
        catch { print(error.localizedDescription) }
    }
}
