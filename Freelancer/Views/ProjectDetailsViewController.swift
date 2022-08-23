//
//  ProjectDetailsViewController.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit

// 2. TODO: - Use UIKit to implement ProjectDetailsViewController view

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

    enum State {
        case started
        case stopped
    }

    var buttonState: State = .stopped

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = project.name
        navigationItem.hidesBackButton = false
        descriptionTextView.addDoneButton(
            title: "Done",
            target: self,
            selector: #selector(tapDone(sender:))
        )
    }

    override func loadView() {
        super.loadView()
        buttonStartProgress.style()
        buttonSave.style()
        descriptionTextView.style()
        projectDoneSwitch.isOn = project.completed
        timeSpentValueLabel.text = String("\(projectViewModel.timeSpent(project)) hours")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if buttonState == .started {
            stopProgress()
        }
        projectViewModel.updateProject(
            project.name,
            descriptionTextView.text,
            projectDoneSwitch.isOn,
            projectDetailsViewModel.sessionDuration
        )
        super.viewWillDisappear(animated)
    }

    // MARK: IBActions

    @objc func tapDone(sender: Any) {
        view.endEditing(true)
    }

    @IBAction func startProgress(_ sender: Any) {
        if buttonState == .stopped {
            startProgress()
        } else {
            stopProgress()
        }
    }
    @IBAction func saveTap(_ sender: Any) {
        coordinator?.goToProjectList()
    }

    // MARK: Helpers

    func startProgress() {
        guard buttonState == .stopped else {
            return
        }
        projectDetailsViewModel.startDate = Date()
        buttonState = .started
        buttonStartProgress.setTitle("Stop Progress", for: .normal)
        buttonStartProgress.backgroundColor = Theme.Color.buttonStateStoped
    }

    func stopProgress() {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: 60, to: Date())
        projectDetailsViewModel.endDate = date
        buttonState = .stopped
        buttonStartProgress.setTitle("Start Progress", for: .normal)
        let duration = projectViewModel.timeSpent(project) + projectDetailsViewModel.sessionDuration
        timeSpentValueLabel.text = "\(duration) hours"
        buttonStartProgress.backgroundColor = Theme.Color.buttonStateStarted
    }
}
