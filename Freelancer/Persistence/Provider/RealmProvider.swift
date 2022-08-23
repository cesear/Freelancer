//
//  RealmConfiguration.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation
import RealmSwift

// MARK: - RealmProvider

struct RealmProvider {

    // MARK: - Properties

    let configuration: Realm.Configuration

    private var realm: Realm? {
        do {
            return try Realm(configuration: configuration)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    // MARK: - Init
    internal init(config: Realm.Configuration) {
        configuration = config
    }

    // MARK: - Configuration

    private static let defaultConfig = Realm.Configuration(schemaVersion: 1)
    private static let mainConfig = Realm.Configuration(
        fileURL: URL.inDocumentsFolder(fileName: "main.realm"),
        schemaVersion: 1
    )

    // MARK: - Realm Instances

    public static var `default`: Realm? = {
        return RealmProvider(config: RealmProvider.defaultConfig).realm
    }()
    public static var main: Realm? = {
        return RealmProvider(config: RealmProvider.mainConfig).realm
    }()
}
