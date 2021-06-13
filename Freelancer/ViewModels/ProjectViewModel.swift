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
        self.projectRepository = ProjectRepository.init(dbManager: dbManager)
    }
    
    func exist(_ projectDto: ProjectDTO)->Bool{
        return self.projectRepository.exist(projectDto)
    }
    
    func saveProject(_ projectDto: ProjectDTO) {
        self.projectRepository.saveProject(projectDto)
    }
    
    func getProjects(){
        let projectDto = self.projectRepository.getAllProjects()
        print(projectDto)
    }
    
    func deleteAllProjects() {
        self.projectRepository.deleteAll()
    }
    
    func deleteProject(_ projectDto: ProjectDTO) {
        self.projectRepository.delete(projectDto)
    }

    func saveOrDelete(){
        let projectDto = ProjectDTO.init(name: "Freelancer", completed: false, timeSpent: 10)
        if !self.exist(projectDto){
            self.saveProject(projectDto)
        } else{
            self.deleteProject(projectDto)
        }
    }
}
