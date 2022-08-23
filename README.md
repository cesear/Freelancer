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

1. From ProjectTableViewController viewDidLoad updated viewModel.updateDataSourceHandler with didUpdate()
1. Use UIKit to implement ProjectDetailsViewController UI instead of storyboard use snapkit to make the costraints
1. Use SwiftUI to implement ProjectTableViewController and ArchivedProjectsTableViewController UI instead of storyboard
1. Implement unit tests
1. Implement UI tests using Snapshotkit
1. Add search for a project by name (projects in progress only)

1. Implement Cascade when deleting a project so all sessions are also deleted ( ## Bonus Tasks )
1. Use combine in ArchivedProjectsTableViewController to fetch the data source ( ## Bonus Tasks )

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
