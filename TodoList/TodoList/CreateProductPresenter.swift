//
//  CreateProductPresenter.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 13.09.2021.
//

import Foundation

class CreateProductPresenter: CreatProductViewOutput  {
    var productService : ProductService = ProductService.shared
    weak var view: CreatProductViewInput!
    
    init(view: CreatProductViewInput) {
        self.view = view
    }
    
    func save(_ product: Product) {
        do {
            try product.validation()
            try productService.save(product)
            view.resetFields()
        } catch {
            view.show(error)
        }
    }
}

