//
//  UITextView.swift
//  Freelancer
//
//  Created by Kais Segni on 15/06/2021.
//

import UIKit
extension UITextView{
    func style() {
        self.clipsToBounds = false
        self.layer.shadowOpacity=0.4
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
