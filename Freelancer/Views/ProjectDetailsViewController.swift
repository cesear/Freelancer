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
    let viewModel = ProjectDetailsViewModel()
    enum State{
        case started
        case stopped
    }
    var buttonState: State = .stopped
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Project session"
        self.navigationItem.hidesBackButton = true
        self.viewModel.updateDataSourceHandler = { [weak self] in self?.didUpdate() }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.viewModel.unbind()
        super.viewWillDisappear(animated)
    }
    
    @IBAction func startProgress(_ sender: Any) {
        if buttonState == .stopped{
            viewModel.startDate = Date()
            buttonState = .started
            self.buttonStartProgress.setTitle("Stop Progress", for: .normal)
        } else {
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .minute, value: 123, to: Date())
            viewModel.endDate = date
            buttonState = .stopped
            self.buttonStartProgress.setTitle("Start Progress", for: .normal)
        }
        
    }
    @IBAction func saveTap(_ sender: Any) {
        self.viewModel.updateProject(project.name, self.descriptionTextView.text, completed: self.projectDoneSwitch.isOn)
        coordinator?.start()
    }
    
    func didUpdate(){
        print(self.viewModel.getSessions().map({$0.sessionId}))
    }
}

