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
        self.goToProjectList()
    }
    
    func goToProjectDetailsViewController(_ project: ProjectDTO){
        let vc = ProjectDetailsViewController.instantiate()
        vc.coordinator = self
        vc.project = project
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToProjectList(){
        let vc = ProjectTableViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func didFinish(_ coordinator: Coordinator) {
        self.childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
