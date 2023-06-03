//
//  Service.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 13.09.2021.
//

import UIKit
import CoreData

protocol ProductServiceProtocol {
    var products: [Product] { get }
    
    func deleteProducts() throws
    func deleteProduct(_ index: Int) throws
    func save(_ product: Product) throws 
    func changeProduct(product: Product, selectedIndex: Int) throws
}

class ProductService: ProductServiceProtocol {
    var products: [Product] = []
    var productsEntity: [ProductEntity] = []
    
    static var shared: ProductService = ProductService()
    private init() {
        productsEntity = fetchProducts()
        products = map(products: productsEntity)
    }
   
    func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    private func fetchProducts() -> [ProductEntity] {
        guard let context = getContext(), let products = try? context.fetch(ProductEntity.fetchRequest()) else {
            return []
        }
        return products
    }
    
    func map(products: [ProductEntity]) -> [Product] {
        var newProducts: [Product] = []
        for index in 0 ..< products.count {
            let name = products[index].name ?? ""
            let count = Int(products[index].count)
            let prodact = Product(name: name, count: count)
            newProducts.append(prodact)
        }
        return newProducts
    }
    
    func deleteProduct(_ index: Int) throws {
        guard let context = getContext() else {
            throw SystemError.default
        }
        products.remove(at: index)
        let product = productsEntity[index]
        context.delete(product)

        try context.save()
    }
    
    func deleteProducts() throws {
        guard let context = getContext() else {
            throw SystemError.default
        }
        for index in 0 ..< productsEntity.count {
            let product = productsEntity[index]
            context.delete(product)
        }
        
        try context.save()
        productsEntity.removeAll()
        products.removeAll()
    }
    
    func save(_ product: Product) throws {
        guard let context = getContext() else {
            throw SystemError.default
        }
        let productEntity = ProductEntity(context: context)
        productEntity.name = product.name
        productEntity.count = Int32(product.count)

        try context.save()

        products.append(product)
        productsEntity.append(productEntity)
    }
    
    func changeProduct(product: Product, selectedIndex: Int) throws {
        products[selectedIndex] = product
        
        productsEntity[selectedIndex].name = product.name
        productsEntity[selectedIndex].count = Int32(product.count)
        guard let context = getContext() else {
            throw SystemError.default
        }
        try context.save()
    }
    
}
