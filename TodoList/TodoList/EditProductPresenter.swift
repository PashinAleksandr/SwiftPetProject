//
//  EditProductPresenter.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 19.09.2021.
//

import Foundation

class EditProductPresenter: EditProductViewOutput {
    
    var productService: ProductService = ProductService.shared
    weak var view: EditProductViewInput!
   
    init(view: EditProductViewInput) {
        self.view = view
    }

    func edit(_ product: Product, index: Int) {
        do {
            try product.validation()
            try productService.changeProduct(product: product, selectedIndex: index)
        } catch {
            view.show(error)
        }
    }
 
}


