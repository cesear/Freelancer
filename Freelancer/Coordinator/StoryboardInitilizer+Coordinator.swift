//
//  StoryboardInitilizer+Coordinator.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit

extension StoryboardInitilizer where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
