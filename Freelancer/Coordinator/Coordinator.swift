//
//  Coordinator.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func didFinish(_ coordinator: Coordinator)
    func start()
}


