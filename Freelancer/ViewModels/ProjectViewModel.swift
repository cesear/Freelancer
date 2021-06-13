//
//  ProjectViewModel.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation
class ProjectViewModel {
    
    let dbManager: DataManager
    let projectRepository: ProjectRepository
    
    init(dbManager: DataManager = DBManager(RealmProvider.default)) {
        self.dbManager = dbManager
        self.projectRepository = ProjectRepository(dbManager: dbManager)
    }
    
    func exist(_ projectDto: ProjectDTO)->Bool{
        return self.projectRepository.exist(projectDto)
    }
    
    func exist(_ name: String)->Bool{
        let projectDto = ProjectDTO(name: name)
        return self.projectRepository.exist(projectDto)
    }
    
    func saveProject(_ projectDto: ProjectDTO) {
        self.projectRepository.saveProject(projectDto)
    }
    
    func saveProject(_ name: String, _ completed: Bool, _ timeSpent: Int) {
        let projectDto = ProjectDTO.init(name: name, completed: completed, timeSpent: timeSpent)
        if !exist(projectDto){
            self.saveProject(projectDto)
        } else{
            print("project_exist_error".localized)
        }
    }
    
    func getProjects()->[ProjectDTO]{
        return self.projectRepository.getAllProjects()
    }
    
    func deleteProjects() {
        self.projectRepository.deleteAll()
    }
    
    func deleteProject(_ projectDto: ProjectDTO) {
        self.projectRepository.delete(projectDto)
    }
}
