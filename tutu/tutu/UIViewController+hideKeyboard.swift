//
//  UIViewController+hideKeyboard.swift
//  tutu
//
//  Created by Aleksandr Pashin on 29.10.2021.
//

import UIKit


extension UIViewController {
    func hideKeyboardWhenSuperviewTapped() {
        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(superviewDidTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func superviewDidTapped() {
        view.endEditing(true)
    }
}
