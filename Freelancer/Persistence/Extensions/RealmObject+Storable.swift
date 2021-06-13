//
//  RealmObject+Storable.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation
import RealmSwift

extension Object: Storable {
    
}

public struct Sorted {
    var key: String
    var ascending: Bool = true
}

