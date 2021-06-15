//
//  ProjectViewModel.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation
import RealmSwift

class ProjectViewModel {
    
    let dbManager: DataManager
    let projectRepository: ProjectRepository
    var notificationToken: NotificationToken?
    var updateDataSourceHandler: (() -> Void)?
    let sessionRepository: SessionRepository
    init(dbManager: DataManager = DBManager(RealmProvider.default)) {
        self.dbManager = dbManager
        self.projectRepository = ProjectRepository(dbManager: dbManager)
        self.sessionRepository = SessionRepository(dbManager: dbManager)
    }
    
    func bind(){
        self.observeChanges()
    }
    
    func unbind(){
        self.notificationToken?.invalidate()
        self.notificationToken = nil
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
    
    func saveProject(_ name: String, _ completed: Bool, _ timeSpent: Double) {
        let projectDto = ProjectDTO.init(name: name, completed: completed)
        if !exist(projectDto){
            self.saveProject(projectDto)
        } else{
            print("project_exist_error".localized)
        }
    }
    
    func updateProject(_ projectDTO: ProjectDTO) {
        self.projectRepository.update(projectDTO)
    }
    
    func getProjects()->[ProjectDTO]{
        return self.projectRepository.getAllProjects()
    }
    
    func deleteProjects() {
        self.projectRepository.deleteAll()
    }
    
    // Cascade deleting should be implemented 
    func deleteProject(_ projectDto: ProjectDTO) {
        let sessions = projectDto.sessions
        self.projectRepository.delete(projectDto)
        for session in sessions{
            let predicate =  NSPredicate(format: "sessionId == %@", session.sessionId)
            self.sessionRepository.delete(session, predicate: predicate)
        }
    }
    
    // duration is a session duration
    func updateProject(_ name: String, _ description: String, _ completed: Bool, _ sessionLength: Double) {
        let predicate = NSPredicate(format: "name == %@", name)
        if let projectDto = self.projectRepository.getProject(predicate: predicate){
            var projectDto = projectDto
            projectDto.sessions.append(SessiontDTO(sessionLength: sessionLength, sessionDescription: description))
            projectDto.completed = completed
            self.projectRepository.update(projectDto)
        }
    }
    
    func getSessions()->[SessiontDTO]{
        return self.sessionRepository.getAllSessions()
    }
    
    func timeSpent(_ project: ProjectDTO)->Double{
        return project.sessions.map({$0.sessionLength}).reduce(0, +)
    }
    
    func observeChanges(){
        if let results = self.projectRepository.getAll(){
            notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
                print("Update received")
                self?.updateDataSourceHandler?()
            }
        }
    }
}
