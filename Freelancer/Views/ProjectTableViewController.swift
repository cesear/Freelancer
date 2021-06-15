//
//  ProjectTableViewController.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit
import RealmSwift
class ProjectTableViewController: UITableViewController, StoryboardInitilizer {
    
    let viewModel = ProjectViewModel()
    weak var coordinator: AppCoordinator?
    var dataSource: [ProjectDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.dataSource = viewModel.getProjects()
        self.viewModel.updateDataSourceHandler = { [weak self] in self?.didUpdate() }
        let addButton = UIBarButtonItem(title: "add".localized, style: .plain, target: self, action: #selector(addTapped))
        addButton.title = "add_project_title".localized
        self.navigationItem.rightBarButtonItem = addButton
        self.title = "projects".localized
        self.tableView.tableFooterView = UIView()
        // Test data
        /*viewModel.saveProject("Swift", false, 20)
        viewModel.saveProject("Paython", false, 10)
        viewModel.saveProject("Flutter", false, 15)*/
        let projects = viewModel.getProjects()
        print("projects \(projects.map({$0.name}))")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.bind()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.viewModel.unbind()
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.filter({$0.completed == true}).count > 0 ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.dataSource.filter({!$0.completed}).count : self.dataSource.filter({$0.completed}).count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath)
            cell.textLabel?.text = "Project: \(self.dataSource.filter({!$0.completed})[indexPath.row].name)"
            let timeSpent = self.viewModel.timeSpent(self.dataSource.filter({!$0.completed})[indexPath.row])
            cell.detailTextLabel?.text = "Amount spent: \(timeSpent)"
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath)
            cell.textLabel?.text = "Project: \(self.dataSource.filter({$0.completed})[indexPath.row].name)"
            let timeSpent = self.viewModel.timeSpent(self.dataSource.filter({$0.completed})[indexPath.row])
            cell.detailTextLabel?.text = "Amount spent: \(timeSpent)"
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteContextAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            let project = self.dataSource[indexPath.row]
            self.showAlertWithTwoButtons("Delete \(project.name)",  "Are you sure you want to delete \(project.name) ?", okButtonTitle: "Ok", {
                self.viewModel.deleteProject(project)
            }, cancelButtonTitle: "Cancel", nil)
        }
        
        let invoiceContextAction = UIContextualAction(style: .normal, title: "Invoice") {  (contextualAction, view, boolValue) in
            let project = indexPath.section == 0 ? self.dataSource.filter({!$0.completed})[indexPath.row] : self.dataSource.filter({$0.completed})[indexPath.row]
            let amount = self.viewModel.invoicedAmount(project)
            if amount > 0{
                self.showAlertWithTwoButtons("Invoice \(project.name)",  "Are you sure you want to invoice \(amount) dkk ?", okButtonTitle: "Ok", {
                    self.viewModel.invoice(project)
                }, cancelButtonTitle: "Cancel", nil)
            } else{
                self.showAlertWithOneButton("Unable to invoice amount", self.viewModel.timeSpent(project) > 0 ? "Amount was already invoiced" : "Log work sessions before requesting an invoice")
            }

        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteContextAction, invoiceContextAction])
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            self.coordinator?.goToProjectDetailsViewController(dataSource.filter({!$0.completed})[indexPath.row])
        } else{
            self.coordinator?.goToProjectDetailsViewController(dataSource.filter({$0.completed})[indexPath.row])
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        if section == 0  {
            if dataSource.filter({!$0.completed}).count > 0{
                title = "In progress"
            }
        }
        if section == 1  {
            if dataSource.filter({$0.completed}).count > 0{
                title = "Completed"
            }
        }
        return title
    }
    
    //MARK: Helpers
    
    @objc private func addTapped() {
        self.showInputDialog(title: "Add project", subtitle: "Add project name", actionTitle: "Ok", cancelTitle: "Cancel", inputPlaceholder: "Project name here", inputKeyboardType: .asciiCapable, cancelHandler: nil, actionHandler: { name in
            if let prpjectName = name{
                if !self.viewModel.exist(prpjectName){
                    self.viewModel.saveProject(prpjectName, false, 0)
                } else{
                    self.showAlertWithOneButton("An error occured", "An other project named \(prpjectName) already exist")
                }
                
            }
        })
    }
    
    func didUpdate(){
        self.dataSource = self.viewModel.getProjects()
        self.tableView.reloadData()
    }
    

}

