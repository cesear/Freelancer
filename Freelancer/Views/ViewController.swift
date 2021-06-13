//
//  ViewController.swift
//  Freelancer
//
//  Created by Kais Segni on 10/06/2021.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ProjectViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.saveOrDelete()
        viewModel.getProjects()
    }


}

