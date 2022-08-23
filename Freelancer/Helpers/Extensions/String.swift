//
//  String.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, value: "\(self)", comment: "")
    }
}
