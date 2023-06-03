//
//  ProductEntity+CoreDataProperties.swift
//  TodoList
//
//  Created by Aleksandr Pashin on 23.08.2021.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var count: Int32

}

extension ProductEntity : Identifiable {

}
