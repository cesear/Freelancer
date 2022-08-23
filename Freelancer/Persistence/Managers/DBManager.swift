//
//  DBManager.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//
import Foundation
import RealmSwift

// MARK: - DataManager Implementation

class DBManager {

    // MARK: - Properties

    let realm: Realm?
    init(_ realm: Realm?) {
        self.realm = realm
    }
}
enum RealmError: Error {
    case eitherRealmIsNilOrNotRealmSpecificModel
}
extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .eitherRealmIsNilOrNotRealmSpecificModel:
            return NSLocalizedString(
                "eitherRealmIsNilOrNotRealmSpecificModel",
                comment: "eitherRealmIsNilOrNotRealmSpecificModel"
            )
        }
    }
}
