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

    let pythonProject = ProjectDTO(name: "Python", completed: false)
    let javatProject = ProjectDTO(name: "Java", completed: false)
    let swiftProject = ProjectDTO(name: "Swift", completed: false)

    override func setUp() {}
    
    override func tearDown() {}

    // TODO: - Task 1 implement unit tests

    func testSaveProject() {}
    func testFetchProject() {}
    func testDeleteProject() {}
    func testProjectExist() {}
    func testFetchAllProjects() {}
    func testFetchCompletedProjects() {}
    func testFetchArchivedProjects() {}
}
