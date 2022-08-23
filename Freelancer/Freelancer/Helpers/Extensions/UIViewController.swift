//
//  UIViewController.swift
//  Freelancer
//
//  Created by Kais Segni on 14/06/2021.
//

import UIKit

extension UIViewController{
    @discardableResult
    func showAlertWithOneButton(_ title: String, _ message: String, buttonTitle: String? = "ok".localized, _ handler: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            handler?()
        })
        alert.addAction(okBtn)
        self.present(alert, animated: true)
        return alert
    }
    
    @discardableResult
    func showAlertWithTwoButtons(_ title: String, _ message: String, okButtonTitle: String? = "ok".localized, _ okButtonHandler: (() -> Void)? = nil, cancelButtonTitle: String? = "cancel".localized, _ cancelButtonHandler: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: okButtonTitle, style: .default, handler: { _ in
            okButtonHandler?()
        })
        let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .destructive, handler: { _ in
            cancelButtonHandler?()
        })
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        
        self.present(alert, animated: true)
        
        return alert
    }
    
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
