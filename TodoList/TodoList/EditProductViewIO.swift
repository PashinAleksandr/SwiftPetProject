//
//  EditProductViewIO.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 19.09.2021.
//

import Foundation
import UIKit

protocol EditProductViewInput: AnyObject, UIViewInput {
    func back()
}

protocol EditProductViewOutput {
    func edit(_ product: Product, index: Int) 
}
