//
//  AlertExtension.swift
//  tutu
//
//  Created by Aleksandr Pashin on 27.10.2021.
//

import Foundation
import UIKit

protocol UIViewInput {
    func showAlert(title: String, massege: String)
}

extension UIViewInput {
    func showAlert(title: String, massege: String) {
        guard let self = self as? UIViewController else {return}
        let alert = UIAlertController(title: title, message: massege, preferredStyle: .alert)
        let okActions = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okActions)
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(_ error: Error) {
        return showAlert(title: "Error", massege: error.localizedDescription)
    }
}
