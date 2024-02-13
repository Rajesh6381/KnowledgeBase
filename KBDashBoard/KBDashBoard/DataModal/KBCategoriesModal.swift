//
//  KBModal.swift
//  KBDashBoard
//
//  Created by zoho on 09/02/24.
//

import Foundation



struct KBCategoriesModal: Codable{
    
    let data: [KBCategoriesModals]
    
    enum CodingKeys: String,CodingKey{
        case data
    }
}

struct KBCategoriesModals: Codable{
    let isFollowing: Bool
    let articlesCount:String
    let articleViewType:String
    let webUrl:String
    let logoUrl:String
    let sectionsCount:String
    let associatedDepartmentIds:[String]
    let primaryDepartmentId:String
    let translatedName:String
    let name:String
    let description:String
    let visibility:String
    let id:String
    let permalink: String
    let translatedDescription: String
    let locale: String
    
    enum CodingKeys: String, CodingKey {
            case isFollowing, articlesCount, articleViewType
            case webUrl
            case logoUrl
            case sectionsCount
            case associatedDepartmentIds
            case primaryDepartmentId 
            case translatedName, name, description, visibility, id, permalink, translatedDescription, locale
        }
}


