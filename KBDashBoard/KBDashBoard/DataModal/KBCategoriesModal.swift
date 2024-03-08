//
//  KBModal.swift
//  KBDashBoard
//
//  Created by zoho on 09/02/24.
//

import Foundation

struct DataModal<T: Codable> : Codable{
    let data: [T]
    
    enum CodingKeys: String,CodingKey{
        case data
    }
}


// MARK: - KBCategories
struct KBCategoriesModal: Codable{
    let isFollowing: Bool
    let articlesCount:String
    let articleViewType:String?
    let webUrl:String
    let logoUrl:String?
    let sectionsCount:String
    let associatedDepartmentIds:[String]?
    let primaryDepartmentId:String?
    let translatedName:String
    let name:String
    let description:String?
    let visibility:String
    let id:String
    let permalink: String
    let translatedDescription: String?
    let locale: String
    
    //subCategories
    let level: String?
    let rootCategoryId: String?
    let child: [KBCategoriesModal]?
    let parentCategoryId: String?
    
    enum CodingKeys: String, CodingKey {
            case isFollowing, articlesCount, articleViewType
            case webUrl
            case logoUrl
            case sectionsCount
            case associatedDepartmentIds
            case primaryDepartmentId
            case translatedName, name, description, visibility, id, permalink, translatedDescription, locale
            case level
            case rootCategoryId
            case child
            case parentCategoryId
        
    }
}




import Foundation


// MARK: - Articles
struct KBArticlesModal: Codable {
    let title: String?
    let category: Category?
    let locale: String?
    let id: String
    let summary, permalink, modifiedTime: String?
    let categoryId: String?
    let webUrl: String?
    let createdTime, translationId, rootCategoryId: String
    let likeCount, dislikeCount, answer: String?

    enum CodingKeys: String, CodingKey {
        case title, category, locale, id, summary, permalink, modifiedTime
        case categoryId
        case webUrl
        case createdTime
        case translationId
        case rootCategoryId
        case likeCount, dislikeCount, answer
    }
}

// MARK: - Category
struct Category: Codable {
    let name: String
    let id: String
    let locale: String
    
    enum CodingKeys: String,CodingKey{
        case name, id, locale
    }
}

