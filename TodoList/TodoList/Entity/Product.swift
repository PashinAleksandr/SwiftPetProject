//
//  Product.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 08.08.2021.
//

struct Product {
    let name: String
    let count: Int
    
    func validation() throws {
        if self.count < 1 {
            throw ValidationError.emptyCount
        }

        if self.name.isEmpty {
            throw ValidationError.emptyProductName
        }
    }
}
