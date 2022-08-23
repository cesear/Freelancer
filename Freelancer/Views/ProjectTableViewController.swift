//
//  ProjectTableViewController.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit
import RealmSwift

// 3. TODO: - Use SwiftUI to implement ProjectTableViewController

class ProjectTableViewController: UITableViewController, StoryboardInitilizer {

    let viewModel = ProjectViewModel()
    weak var coordinator: AppCoordinator?
    var dataSource: ([ProjectDTO], [ProjectDTO])!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        dataSource = viewModel.dataSource()
        viewModel.updateDataSourceHandler = {
            /*
             1. TODO: - call did didUpdate()
             */
        }
        let addButton = UIBarButtonItem(
            title: "add".localized,
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
        navigationItem.rightBarButtonItem = addButton
        let archivedButton = UIBarButtonItem(
            title: "archived".localized,
            style: .plain,
            target: self,
            action: #selector(archivedTapped)
        )
        navigationItem.leftBarButtonItem = archivedButton
        title = "projects".localized
        tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.bind()
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.unbind()
        super.viewWillDisappear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.1.count > 0 ? 2 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? dataSource.0.count : dataSource.1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath)
            cell.textLabel?.text = "Project: \(dataSource.0[indexPath.row].name)"
            let timeSpent = viewModel.timeSpent(dataSource.0[indexPath.row])
            cell.detailTextLabel?.text = "Amount spent: \(timeSpent)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath)
            cell.textLabel?.text = "Project: \(dataSource.1[indexPath.row].name)"
            let timeSpent = viewModel.timeSpent(dataSource.1[indexPath.row])
            cell.detailTextLabel?.text = "Amount spent: \(timeSpent)"
            return cell
        }
    }

    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteContextAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _  in
            let project = indexPath.section == 0 ? self.dataSource.0[indexPath.row] : self.dataSource.1[indexPath.row]
            self.showAlertWithTwoButtons(
                "Delete \(project.name)",
                "Are you sure you want to delete \(project.name) ?",
                okButtonTitle: "Ok", { self.viewModel.deleteProject(project) },
                cancelButtonTitle: "Cancel",
                nil
            )
        }

        let invoiceContextAction = UIContextualAction(style: .normal, title: "Invoice") {  _, _, _ in
            let project = indexPath.section == 0 ? self.dataSource.0[indexPath.row] : self.dataSource.1[indexPath.row]
            let amount = self.viewModel.invoicedAmount(project)
            if amount > 0 {
                self.showAlertWithTwoButtons(
                    "Invoice \(project.name)",
                    "Are you sure you want to invoice \(amount) dkk ?",
                    okButtonTitle: "Ok", { self.viewModel.invoice(project) },
                    cancelButtonTitle: "Cancel",
                    nil
                )
            } else {
                self.showAlertWithOneButton(
                    "Unable to invoice amount",
                    self.viewModel.timeSpent(project) > 0 ?
                    "Amount was already invoiced" : "Log work sessions before requesting an invoice"
                )
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteContextAction, invoiceContextAction])
        return swipeActions
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            coordinator?.goToProjectDetailsViewController(dataSource.0[indexPath.row])
        } else {
            coordinator?.goToProjectDetailsViewController(dataSource.1[indexPath.row])
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        if section == 0 {
            if dataSource.0.count > 0 {
                title = "In progress"
            }
        }
        if section == 1 {
            if dataSource.1.count > 0 {
                title = "Completed"
            }
        }
        return title
    }

    // MARK: Helpers

    @objc private func addTapped() {
        showInputDialog(
            title: "Add project",
            subtitle: "Add project name",
            actionTitle: "Ok",
            cancelTitle: "Cancel",
            inputPlaceholder: "Project name here",
            inputKeyboardType: .asciiCapable,
            cancelHandler: nil,
            actionHandler: { name in
                if let prpjectName = name {
                    if !self.viewModel.exist(prpjectName) {
                        self.viewModel.saveProject(prpjectName, false)
                } else {
                    self.showAlertWithOneButton(
                        "An error occured",
                        "An other project named \(prpjectName) already exist"
                    )
                }
            }
        })
    }

    @objc private func archivedTapped() {
        coordinator?.goToProjectArchive()
    }

    func didUpdate() {
        dataSource = viewModel.dataSource()
        tableView.reloadData()
    }
}
