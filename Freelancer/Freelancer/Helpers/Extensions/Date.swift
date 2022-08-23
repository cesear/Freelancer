//
//  Date.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import Foundation
extension Date{
    func numberOfMinutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
}
