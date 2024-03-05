//
//  CoreDataKBArticleModal+CoreDataProperties.swift
//  KBDashBoard
//
//  Created by Rajesh R on 05/03/24.
//
//

import Foundation
import CoreData


extension CoreDataKBArticleModal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataKBArticleModal> {
        return NSFetchRequest<CoreDataKBArticleModal>(entityName: "CoreDataKBArticleModal")
    }

    @NSManaged public var answer: String?
    @NSManaged public var categoryId: String?
    @NSManaged public var createdTime: String?
    @NSManaged public var dislikeCount: String?
    @NSManaged public var id: String
    @NSManaged public var likeCount: String?
    @NSManaged public var locale: String?
    @NSManaged public var modifiedTime: String?
    @NSManaged public var permalink: String?
    @NSManaged public var rootcategoryId: String?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var translationId: String?
    @NSManaged public var webUrl: String?

}

extension CoreDataKBArticleModal : Identifiable {

}
