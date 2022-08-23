//
//  UITextView.swift
//  Freelancer
//
//  Created by Kais Segni on 15/06/2021.
//

import UIKit

extension UITextView {
    func style() {
        clipsToBounds = false
        layer.shadowOpacity=0.4
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }

    func addDoneButton(title: String, target: Any, selector: Selector) {

        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        inputAccessoryView = toolBar
    }
}
