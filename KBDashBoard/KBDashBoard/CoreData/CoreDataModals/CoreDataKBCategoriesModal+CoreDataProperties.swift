//
//  CoreDataKBCategoriesModal+CoreDataProperties.swift
//  
//
//  Created by Rajesh R on 22/02/24.
//
//

import Foundation
import CoreData


extension CoreDataKBCategoriesModal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataKBCategoriesModal> {
        return NSFetchRequest<CoreDataKBCategoriesModal>(entityName: "CoreDataKBCategoriesModal")
    }

    @NSManaged public var articlesCount: String?
    @NSManaged public var categoriesDescription: String?
    @NSManaged public var id: String
    @NSManaged public var isFollowing: Bool
    @NSManaged public var level: String?
    @NSManaged public var locale: String?
    @NSManaged public var logoUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var parentCategoryId: String?
    @NSManaged public var permalink: String?
    @NSManaged public var primaryDepartmentIds: String?
    @NSManaged public var rootCategoryId: String?
    @NSManaged public var sectionsCount: String?
    @NSManaged public var transalatedDescription: String?
    @NSManaged public var translatedName: String?
    @NSManaged public var visibility: String?
    @NSManaged public var webUrl: String?

}
