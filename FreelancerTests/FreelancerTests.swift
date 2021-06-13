//
//  FreelancerTests.swift
//  FreelancerTests
//
//  Created by Kais Segni on 10/06/2021.
//

import XCTest
@testable import Freelancer

class ProjectTests: XCTestCase {
    
    var viewModel: ProjectViewModel!
    let projectDto = ProjectDTO.init(name: "Freelancer", completed: false, timeSpent: 10)
    override func setUp() {
        self.viewModel = ProjectViewModel()
        self.viewModel.deleteAllProjects()
    }
    
    override func tearDown() {
        self.viewModel = nil
    }
    
    func testSaveProject() {
        viewModel.saveProject(projectDto)
        XCTAssertTrue(viewModel.exist(projectDto))
        viewModel.deleteProject(projectDto)
        XCTAssertFalse(viewModel.exist(projectDto))
    }    
}
