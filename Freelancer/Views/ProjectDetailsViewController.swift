//
//  ProjectDetailsViewController.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit

class ProjectDetailsViewController: UIViewController, StoryboardInitilizer {
    
    weak var coordinator: AppCoordinator?
    var project: ProjectDTO!
    @IBOutlet weak var timeSpentLabel: UILabel!
    @IBOutlet weak var timeSpentValueLabel: UILabel!
    @IBOutlet weak var buttonStartProgress: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var markProjectDoneLabel: UILabel!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var projectDoneSwitch: UISwitch!
    let projectDetailsViewModel = ProjectDetailsViewModel()
    let projectViewModel = ProjectViewModel()
    enum State{
        case started
        case stopped
    }
    var buttonState: State = .stopped
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = project.name
        self.navigationItem.hidesBackButton = true
        self.descriptionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))     
    }
    
    override func loadView() {
        super.loadView()
        self.buttonStartProgress.style()
        self.buttonSave.style()
        self.descriptionTextView.style()
        self.projectDoneSwitch.isOn = project.completed
        self.timeSpentValueLabel.text = String("\(self.projectViewModel.timeSpent(self.project)) hours")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.projectViewModel.updateProject(project.name, self.descriptionTextView.text, self.projectDoneSwitch.isOn, self.projectDetailsViewModel.sessionDuration)
        super.viewWillDisappear(animated)
    }
    
    // MARK: IBActions
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func startProgress(_ sender: Any) {
        if buttonState == .stopped{
            projectDetailsViewModel.startDate = Date()
            buttonState = .started
            self.buttonStartProgress.setTitle("Stop Progress", for: .normal)
            self.buttonStartProgress.backgroundColor = Theme.Color.buttonStateStoped
        } else {
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .minute, value: 60, to: Date())
            projectDetailsViewModel.endDate = date
            buttonState = .stopped
            self.buttonStartProgress.setTitle("Start Progress", for: .normal)
            self.timeSpentValueLabel.text = String ("\(self.projectViewModel.timeSpent(self.project) + self.projectDetailsViewModel.sessionDuration) hours")
            self.buttonStartProgress.backgroundColor = Theme.Color.buttonStateStarted
        }
        
    }
    @IBAction func saveTap(_ sender: Any) {
        coordinator?.goToProjectList()
    }
}

