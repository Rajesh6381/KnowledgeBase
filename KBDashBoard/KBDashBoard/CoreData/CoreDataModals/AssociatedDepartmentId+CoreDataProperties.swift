//
//  AssociatedDepartmentId+CoreDataProperties.swift
//  
//
//  Created by Rajesh R on 19/02/24.
//
//

import Foundation
import CoreData


extension AssociatedDepartmentId {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AssociatedDepartmentId> {
        return NSFetchRequest<AssociatedDepartmentId>(entityName: "AssociatedDepartmentId")
    }

    @NSManaged public var id: String?
    @NSManaged public var ids: KBCategoriesModal?

}
