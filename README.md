# Freelancer
An app that helps freelancers create and manage time spent on different projects, build with swift using realm swift for database management

## Supported features:
- Bob is able to create projects
- Bob is not be able to create projects with the same name twice
- Bob is able to remove projects
- Bob is able to start and stop working on projects
- Bob is able to see an overview of projects and the total time spent on a project in hours
- Bob can invoice customers while working on projects, thus creating an invoice with his base price of 500 DKK per hour spent Creating subsequent invoice for the same project should only contain the hours worked since the last invoice
- Bob can mark projects as completed, thus removing them from the overview, they should however always be visible from a project archive view

## Tasks

- From ProjectTableViewController viewDidLoad updated viewModel.updateDataSourceHandler with didUpdate()
- Use UIKit to implement ProjectDetailsViewController UI instead of storyboard use snapkit to make the costraints
- Implement unit tests
- Use SwiftUI to implement ProjectTableViewController and ArchivedProjectsTableViewController UI instead of storyboard
- Add search for a project by name
- Implement UI tests using Snapshotkit

## Bonus Tasks
- Implement Cascade when deleting a project so all sessions are alos deleted
- Use combine with SwiftUI

## Design patterns

- Coordinator for navigation
- Repository for Data handling

## Packages
* Realm
* Snapshotkit
* snapkit

## Setup
- Install cocoapods
- run pod install from terminal

## Authors

Kais Segni <kais.segni@gmail.com>
