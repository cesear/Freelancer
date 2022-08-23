//
//  Double.swift
//  Freelancer
//
//  Created by Kais Segni on 15/06/2021.
//

import Foundation
extension Double{
    func rounded() -> Double {
        let multiplier = pow(10, Double(3))
        return Darwin.round(self * multiplier) / multiplier
    }
}
