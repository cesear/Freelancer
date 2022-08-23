//
//  UIButton.swift
//  Freelancer
//
//  Created by Kais Segni on 15/06/2021.
//

import UIKit

extension UIButton {
    func style() {
        setTitleColor(.white, for: .normal)
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = Theme.Color.buttonStateStarted
    }
}
