//
//  UIViewInput.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 24.09.2021.
//

import UIKit

protocol UIViewInput {
    func showAlert(title: String, message: String)
    func show(_ error: Error)
    func show(err: Error)
}

extension UIViewInput {
    func showAlert(title: String, message: String) {
        guard let self = self as? UIViewController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(_ error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    func show(err: Error) {
        
    }
}
