//
//  URL+Document.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//

import Foundation

extension URL {

    // returns an absolute URL to the desired file in documents folder

    static func inDocumentsFolder(fileName: String) -> URL {
        return URL(
            fileURLWithPath:
                    NSSearchPathForDirectoriesInDomains(
                        .documentDirectory,
                        .userDomainMask,
                        true
                    )[0],
            isDirectory: true
        ).appendingPathComponent(fileName)
    }
}
