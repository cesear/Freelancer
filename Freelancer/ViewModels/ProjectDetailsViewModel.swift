//
//  ProjectDetailsViewModel.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import Foundation
import RealmSwift

class ProjectDetailsViewModel{
    
    let dbManager: DataManager
    let projectRepository: ProjectRepository
    let sessionRepository: SessionRepository
    var notificationToken: NotificationToken?
    var updateDataSourceHandler: (() -> Void)?
    var startDate: Date?
    var endDate: Date?{
        didSet{
            self.calculateSessionDuration()
        }
    }
    var sessionDuration: Double = 0.0{
        didSet{
            print(sessionDuration)
        }
    }
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
    
    func observeChanges(){
        if let results = self.sessionRepository.getAll(){
            notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
                print("Update received")
                self?.updateDataSourceHandler?()
            }
        }
    }
    
    func exist(_ sessionDto: SessiontDTO)->Bool{
        return self.sessionRepository.exist(sessionDto)
    }
    
    func updateProject(_ name: String,_ description: String, completed: Bool) {
        let projectDto = ProjectDTO.init(name: name, completed: completed, sessions: [SessiontDTO(sessionLength: self.sessionDuration, sessionDescription: description)])
        self.projectRepository.update(projectDto)
    }
    
    func saveSession(_ description: String) {
        let sessionDto = SessiontDTO.init(sessionLength: self.sessionDuration, sessionDescription: "")
        self.sessionRepository.saveSession(sessionDto)
    }
    
    func getSessions()->[SessiontDTO]{
        return self.sessionRepository.getAllSessions()
    }
    func getProjects()->[ProjectDTO]{
        return self.projectRepository.getAllProjects()
    }
    
    func calculateSessionDuration(){
        guard let endDate = self.endDate, let startDate = self.startDate else{
            return
        }
        self.sessionDuration = self.sessionDuration + Double(endDate.numberOfMinutes(from: startDate)) / 60
    }
}
