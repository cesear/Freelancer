//
//  AppCoordinator.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ProjectTableViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToProjectDetailsViewController(){
        let vc = ProjectDetailsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func didFinish(_ coordinator: Coordinator) {
        self.childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
