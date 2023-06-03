//
//  CreateProductViewIO.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 19.09.2021.
//

import Foundation

protocol CreatProductViewInput: AnyObject, UIViewInput {
    func resetFields()
}

protocol CreatProductViewOutput {
    func save(_ product: Product)
}
