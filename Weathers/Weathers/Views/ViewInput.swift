//
//  ViewInput.swift
//  Weathers
//
//  Created by Aleksandr Pashin on 28.01.2022.
//
import Foundation
import UIKit

protocol UIViewInput: UIViewController {
    func showAlert(title: String, massege: String, closure: (() -> Void)?)
    func show(_ error: Error)
}

extension UIViewInput {
    func showAlert(title: String, massege: String, closure: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: massege, preferredStyle: .alert)
        let okActions = UIAlertAction(title: "Ok", style: .default) { _ in
            closure?()
        }
        alert.addAction(okActions)
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(_ error: Error) {
        return showAlert(title: "Error", massege: error.localizedDescription)
    }
}
