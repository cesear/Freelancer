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
    let pythonProject = ProjectDTO.init(name: "Python", completed: false)
    let javatProject = ProjectDTO.init(name: "Java", completed: false)
    let swiftProject = ProjectDTO.init(name: "Swift", completed: false)
    override func setUp() {
        self.viewModel = ProjectViewModel()
        self.viewModel.deleteProjects()
    }
    
    override func tearDown() {
        self.viewModel = nil
    }
    
    func testSaveProject() {
        print("Adding python project")
        viewModel.saveProject(pythonProject)
        // Ensure python project was addded
        XCTAssertTrue(viewModel.exist(pythonProject))
        print("Deleting python project")
        viewModel.deleteProject(pythonProject)
        // Ensure python project was deleted
        XCTAssertFalse(viewModel.exist(pythonProject))
        print("Adding Java project")
        viewModel.saveProject(javatProject)
        // Ensure Java project was addded
        XCTAssertTrue(viewModel.exist(javatProject))
        print("Adding Swift project")
        viewModel.saveProject(swiftProject)
        // Ensure Swift project was addded
        XCTAssertTrue(viewModel.exist(swiftProject))
        // Ensure getProjects project returns both Java and Swift projects
        XCTAssertTrue(viewModel.getProjects().count == 2)
        print("Saved projects: \(viewModel.getProjects().map({$0.name}))")
        print("Deleting all projects")
        viewModel.deleteProjects()
        // Ensure all projects were deleted
        XCTAssertTrue(viewModel.getProjects().count == 0)
        print("Remaining projects: \(viewModel.getProjects().map({$0.name}))")
    }
}
