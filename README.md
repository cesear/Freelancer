# Freelancer
An app that helps freelancers create and manage time spent on different projects, build with swift using realm swift for database management

## Recuirements
- Bob must not be able to create projects with the same name twice
- Bob must be able to remove projects
- Bob must be able to start and stop working on projects
- Bob must be able to see an overview of projects and the total time spent on a project in hours
* Nice to have (Bonus tasks)
- Bob would like to invoice customers while working on projects, thus creating an invoice with his base price of 500 DKK per hour spent Creating subsequent invoice for the same project should only contain the hours worked since the last invoice
- Bob would like to mark projects as completed, thus removing them from the overview, they should however always be visible from a project archive view

## Architecture

- This app will use MVVM for the following reasons:
- Separation of concerns.
- Easier to test. 
- Maintainable.
- Lighter view controller.

## Design patterns

- Coordinator for navigation
- Repository for Data handling

## Packages
* Realm

## Setup

## Authors

Kais Segni <kais.segni@gmail.com>
