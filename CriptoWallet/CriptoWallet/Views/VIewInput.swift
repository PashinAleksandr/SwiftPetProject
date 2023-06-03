//
//  VIewInput.swift
//  CriptoWallet
//
//  Created by Aleksandr Pashin on 07.04.2022.
//
import UIKit
import Foundation

protocol UIViewInput: UIViewController {
    func showAlert(title: String, massege: String, closure:(() -> Void)?)
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
    
    func showAlertRetry(title: String, massege: String, closure: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: massege, preferredStyle: .alert)
        let okActions = UIAlertAction(title: "Retry", style: .default) { _ in
            closure?()
        }
        let cancel = UIAlertAction(title: "Cancl", style: .default)
        
        alert.addAction(okActions)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
