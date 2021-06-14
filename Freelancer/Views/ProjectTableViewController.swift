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
        self.dataSource = viewModel.getProjects()
        self.viewModel.updateDataSourceHandler = { [weak self] in self?.shouldUpdate() }
        let addButton = UIBarButtonItem(title: "add".localized, style: .plain, target: self, action: #selector(addTapped))
        addButton.title = "add_project_title".localized
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath)
        cell.textLabel?.text = "Project: \(self.dataSource[indexPath.row].name)"
        cell.detailTextLabel?.text = "Amount spent: \(self.dataSource[indexPath.row].timeSpent)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            let project = self.dataSource[indexPath.row]
            self.showAlertWithTwoButtons("Delete \(project.name)",  "Are you sure you want to delete \(project.name) ?", okButtonTitle: "Ok", {
                self.viewModel.deleteProject(project)
            }, cancelButtonTitle: "Cancel", nil)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.goToProjectDetailsViewController()
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
    
    func shouldUpdate(){
        self.dataSource = self.viewModel.getProjects()
        self.tableView.reloadData()
    }
}
