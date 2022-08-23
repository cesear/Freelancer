//
//  ArchivedProjectsTableViewController.swift
//  Freelancer
//
//  Created by Kais Segni on 15/06/2021.
//

import UIKit
import RealmSwift
class ArchivedProjectsTableViewController: UITableViewController, StoryboardInitilizer {
    
    let viewModel = ProjectViewModel()
    weak var coordinator: AppCoordinator?
    var dataSource: ([ProjectDTO], [ProjectDTO])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        self.dataSource = viewModel.dataSource()
        self.title = "archived".localized
        self.tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.1.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "project", for: indexPath)
        cell.textLabel?.text = "Project: \(self.dataSource.1[indexPath.row].name)"
        let timeSpent = self.viewModel.timeSpent(self.dataSource.1[indexPath.row])
        cell.detailTextLabel?.text = "Amount spent: \(timeSpent)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}
