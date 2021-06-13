//
//  ProjectTableViewController.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit

class ProjectTableViewController: UITableViewController {
    
    let viewModel = ProjectViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(title: "add".localized, style: .plain, target: self, action: #selector(addTapped))
        
        
        addButton.title = "add_project_title".localized
        //optionButton.action = something (put your action here)
        self.navigationItem.rightBarButtonItem = addButton
        
        self.title = "projects".localized
        self.tableView.tableFooterView = UIView()
        // Test data
        viewModel.saveProject("Swift", false, 20)
        viewModel.saveProject("Paython", false, 10)
        viewModel.saveProject("Flutter", false, 15)
        let projects = viewModel.getProjects()
        print("projects \(projects.map({$0.name}))")
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProjects().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath)
        cell.textLabel?.text = "Project: \(self.viewModel.getProjects()[indexPath.row].name)"
        cell.detailTextLabel?.text = "Amount spent: \(self.viewModel.getProjects()[indexPath.row].timeSpent)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            let project = self.viewModel.getProjects()[indexPath.row]
            self.showAlertWithTwoButtons("Delete \(project.name)",  "Are you sure you want to delete \(project.name) ?", okButtonTitle: "Ok", {
                self.viewModel.deleteProject(project)
                self.tableView.reloadData()
            }, cancelButtonTitle: "Cancel", nil)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    //MARK: Helpers
    
    @objc private func addTapped() {
        self.showInputDialog(title: "Add project", subtitle: "Add project name", actionTitle: "Ok", cancelTitle: "Cancel", inputPlaceholder: "Project name here", inputKeyboardType: .asciiCapable, cancelHandler: nil, actionHandler: { name in
            if let prpjectName = name{
                if !self.viewModel.exist(prpjectName){
                    self.viewModel.saveProject(prpjectName, false, 0)
                    self.tableView.reloadData()
                } else{
                    self.showAlertWithOneButton("An error occured", "An other project named \(prpjectName) already exist")
                }

            }
        })
    }
}
