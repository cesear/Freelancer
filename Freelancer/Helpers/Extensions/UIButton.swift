//
//  UIButton.swift
//  Freelancer
//
//  Created by Kais Segni on 15/06/2021.
//

import UIKit

extension UIButton{
    func style() {
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = Theme.Color.buttonStateStarted
    }
    
}
