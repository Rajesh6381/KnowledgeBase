//
//  CoreDataKBArticleModal+CoreDataProperties.swift
//  
//
//  Created by Rajesh R on 22/02/24.
//
//

import Foundation
import CoreData


extension CoreDataKBArticleModal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataKBArticleModal> {
        return NSFetchRequest<CoreDataKBArticleModal>(entityName: "CoreDataKBArticleModal")
    }

    @NSManaged public var categoryId: String?
    @NSManaged public var createdTime: String?
    @NSManaged public var id: String
    @NSManaged public var locale: String?
    @NSManaged public var modifiedTime: String?
    @NSManaged public var permalink: String?
    @NSManaged public var rootcategoryId: String?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var translationId: String?
    @NSManaged public var webUrl: String?

}
