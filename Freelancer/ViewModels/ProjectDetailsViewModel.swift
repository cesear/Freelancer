//
//  ProjectDetailsViewModel.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import Foundation
import RealmSwift

class ProjectDetailsViewModel{
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

    func calculateSessionDuration(){
        guard let endDate = self.endDate, let startDate = self.startDate else{
            return
        }
        self.sessionDuration = self.sessionDuration + Double(endDate.numberOfMinutes(from: startDate)) / 60
    }
}
