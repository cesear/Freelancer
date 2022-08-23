//
//  ProjectDetailsViewModel.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import Foundation

class ProjectDetailsViewModel {

    var startDate: Date?
    var endDate: Date? {
        didSet {
            calculateSessionDuration()
        }
    }
    var sessionDuration: Double = 0.0

    func calculateSessionDuration() {
        guard let endDate = endDate, let startDate = startDate else {
            return
        }
        sessionDuration += Double(endDate.numberOfMinutes(from: startDate)) / 60
    }
}
