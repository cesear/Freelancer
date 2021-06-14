//
//  SessiontDTO+MappableProtocol.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import Foundation

//MARK: - SessiontDTO RealmMappableProtocol
extension SessiontDTO: MappableProtocol{

    func mapToPersistenceObject() -> Session {
        let model = Session()
        model.sessionLength = sessionLength
        model.sessionDescription = sessionDescription
        model.sessionId = UUID().uuidString
        return model
    }
    
    static func mapFromPersistenceObject(_ object: Session) -> SessiontDTO {
        return SessiontDTO(sessionLength: object.sessionLength, sessionDescription: object.sessionDescription, sessionId: object.sessionId)
    }
    
}
