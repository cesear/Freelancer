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
    
    func saveProject() {
        let projectDto = ProjectDTO.init(name: "Freelancer", status: false, timeSpent: 10)
        if !self.projectRepository.exist(projectDto){
            self.projectRepository.saveProject(projectDto)
        } else{
            self.projectRepository.delete(projectDto)
        }
        
    }
    
    func getProjects(){
        let projectDto = self.projectRepository.getAllProjects()
        print(projectDto)
    }
}
