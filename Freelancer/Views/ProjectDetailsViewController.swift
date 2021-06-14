//
//  ProjectDetailsViewController.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit

class ProjectDetailsViewController: UIViewController, StoryboardInitilizer {
    
    weak var coordinator: AppCoordinator?
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Project session"
    }
}
