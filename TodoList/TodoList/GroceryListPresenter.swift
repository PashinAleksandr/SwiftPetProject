//
//  GroceryListPresenter.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 13.09.2021.
//

import Foundation

class GroceryListPresenter: GroceryListViewOutput {

    weak var view: GroceryListViewInput!
    var productService: ProductServiceProtocol = ProductService.shared

    init(view: GroceryListViewInput) {
        self.view = view
    }
    
    func viewWillAppear() {
        let products = productService.products
        if products.isEmpty {
            view.switchTo(state: .emptyList)
        } else {
            view.switchTo(state: .default)
        }
        view.updateTable()
    }
    
    func deleteAllProducts() {
        do{
            try productService.deleteProducts()
            view.switchTo(state: .emptyList)
            view.updateTable()
        } catch {
            view.show(error)
        }
    }
    
    func deleteProduct(_ index: Int) {
        do {
            try productService.deleteProduct(index)
            isFilling()
        } catch {
            view.show(error)
        }
    }
    
    func prepareDataForShare() -> String {
        let products = getProducts()
        
        var productList: String = ""
        for productNomber in 0..<products.count {
            let product = products[productNomber]
            productList += String(productNomber + 1) + ") " + product.name + " - " + String(product.count) + "\n"
        }
        return productList
    }
    
    func getProducts() -> [Product] {
        let products: [Product] = productService.products
        return products
    }

    func isFilling() {
        if productService.products.isEmpty {
            view.switchTo(state: .emptyList)
        }
        view.switchTo(state: .default)
    }

}
