//
//  User+CoreDataClass.swift
//  Core data
//
//  Created by Aleksandr Pashin on 23.08.2021.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable  {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
}
