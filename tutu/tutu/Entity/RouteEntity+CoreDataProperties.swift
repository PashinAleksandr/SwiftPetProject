//
//  RouteEntity+CoreDataProperties.swift
//  tutu
//
//  Created by Aleksandr Pashin on 05.11.2021.
//
//

import Foundation
import CoreData


extension RouteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RouteEntity> {
        return NSFetchRequest<RouteEntity>(entityName: "RouteEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var departurePoint: String?
    @NSManaged public var destination: String?
    @NSManaged public var note: String?

}

extension RouteEntity : Identifiable {

}
