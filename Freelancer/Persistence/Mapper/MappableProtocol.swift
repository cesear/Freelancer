//
//  MappableProtocol.swift
//  Freelancer
//
//  Created by Kais Segni on 12/06/2021.
//
protocol MappableProtocol {
    
    associatedtype PersistenceType: Storable
    
    //MARK: - Method
    func mapToPersistenceObject() -> PersistenceType
    static func mapFromPersistenceObject(_ object: PersistenceType) -> Self
    
}
