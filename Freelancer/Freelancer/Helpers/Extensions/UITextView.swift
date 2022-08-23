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
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
