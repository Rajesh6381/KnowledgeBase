//
//  KBCategoriesModal+CoreDataProperties.swift
//  
//
//  Created by Rajesh R on 19/02/24.
//
//

import Foundation
import CoreData


extension KBCategoriesModal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KBCategoriesModal> {
        return NSFetchRequest<KBCategoriesModal>(entityName: "KBCategoriesModal")
    }

    @NSManaged public var isFollowing: Bool
    @NSManaged public var logoUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var visibility: String?
    @NSManaged public var locale: String?
    @NSManaged public var transalatedDescription: String?
    @NSManaged public var translatedName: String?
    @NSManaged public var permalink: String?
    @NSManaged public var webUrl: String?
    @NSManaged public var sectionCount: String?
    @NSManaged public var primaryDepartmentIds: String?
    @NSManaged public var child: String?
    @NSManaged public var parentCategoryId: String?
    @NSManaged public var rootCategoryId: String?
    @NSManaged public var level: String?
    @NSManaged public var articleCount: String?
    @NSManaged public var articleViewType: String?
    @NSManaged public var associatedDepartmentId: String?
    @NSManaged public var categoriesDescription: String?
    @NSManaged public var associatedDepartmentIds: AssociatedDepartmentId?

}
