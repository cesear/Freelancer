//
//  ProjectRepository.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//
// swiftlint:disable force_cast

import Foundation
import RealmSwift

class ProjectRepository: Repository<Project> {

    func exist(_ projectDTO: ProjectDTO ) -> Bool {
        return super.exist(Project.self, object: projectDTO.mapToPersistenceObject())
    }

    func saveProject(_ projectDTO: ProjectDTO) {
        do {
            try super.save(object: projectDTO.mapToPersistenceObject())
        } catch { print(error.localizedDescription) }
    }

    func getAllProjects(on sort: Sorted? = nil ) -> [ProjectDTO] {
        return super.fetch(
            Project.self,
            predicate: nil,
            sorted: sort
        ).map { ProjectDTO.mapFromPersistenceObject($0 as! Project) }
    }

    func getProject(on sort: Sorted? = nil, predicate: NSPredicate) -> ProjectDTO? {
        return (
            super.fetch(
                Project.self,
                predicate: predicate,
                sorted: sort
            ).map { ProjectDTO.mapFromPersistenceObject($0 as! Project) }
        ).first
    }

    func getAll(on sort: Sorted? = nil ) -> Results<Object>? {
        return super.getAll(Project.self)
    }

    func delete(_ projectDTO: ProjectDTO) {
        do {
            try super.delete(Project.self, object: projectDTO.mapToPersistenceObject(), predicate: nil)
        } catch { print(error.localizedDescription) }
    }

    func deleteAll() {
        do {
            try super.deleteAll(Project.self)
        } catch { print(error.localizedDescription) }
    }

    func update(_ projectDTO: ProjectDTO) {
        do {
            try super.update(object: projectDTO.mapToPersistenceObject())
        } catch { print(error.localizedDescription) }
    }
}
