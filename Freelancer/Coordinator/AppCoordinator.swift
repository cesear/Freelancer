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
        goToProjectList()
    }

    func goToProjectDetailsViewController(_ project: ProjectDTO) {
        let projectDetailsViewController = ProjectDetailsViewController.instantiate()
        projectDetailsViewController.coordinator = self
        projectDetailsViewController.project = project
        navigationController.pushViewController(projectDetailsViewController, animated: false)
    }

    func goToProjectList() {
        let projectTableViewController = ProjectTableViewController.instantiate()
        projectTableViewController.coordinator = self
        navigationController.pushViewController(projectTableViewController, animated: false)
    }

    func goToProjectArchive() {
        let archivedProjectsTableViewController = ArchivedProjectsTableViewController.instantiate()
        archivedProjectsTableViewController.coordinator = self
        navigationController.pushViewController(archivedProjectsTableViewController, animated: false)
    }

    func didFinish(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
