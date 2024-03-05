//
//  KBCategoryPath.swift
//  KBDashBoard
//
//  Created by Rajesh R on 15/02/24.
//

import Foundation

enum URLPath: String{
    case BaseURL = "/portal/api/"
    case KBRootCategoriesPath = "kbRootCategories"
    case KBSubCategoriesPath = "categoryTree"
    case KBArticles = "kbArticles"
}

enum KBCategoryPath{
    case KBRootCategories
    case KBSubCategories(id: String)
    case KBArticles(id: String)
    case KBArticleDetails(id: String)
}

protocol EndPoint{
    var scheme: String {get}
    var baseUrl: String {get}
    var path: String {get}
    var queryItems: [URLQueryItem] {get}
    func makeUrl() -> URL?
}

extension KBCategoryPath: EndPoint{
    
    var scheme: String{
        return "https"
    }
    
    var baseUrl: String{
        return "desk.zoho.com"
    }
    
    var path: String{
        switch self{
            case .KBRootCategories:
                return URLPath.BaseURL.rawValue + URLPath.KBRootCategoriesPath.rawValue
            case .KBSubCategories(let id):
                return URLPath.BaseURL.rawValue + URLPath.KBRootCategoriesPath.rawValue + "/" + id + "/" + URLPath.KBSubCategoriesPath.rawValue
            case .KBArticles(_):
                return URLPath.BaseURL.rawValue + URLPath.KBArticles.rawValue
            case .KBArticleDetails(let id):
                return URLPath.BaseURL.rawValue + URLPath.KBArticles.rawValue + "/" + id
        }
    }
    
    var queryItems: [URLQueryItem]{
        switch self{
        case .KBRootCategories, .KBSubCategories(_ ):
            return [
                URLQueryItem(name: "hasArticles", value: "true"),
                URLQueryItem(name: "include", value: "articlesCount"),
                URLQueryItem(name: "include", value: "sectionsCount"),
                URLQueryItem(name: "portalId", value: PortalId.TestIdentifier.rawValue)
                
            ]
            
        case .KBArticles(let id):
            return [
                URLQueryItem(name: "categoryId", value: id),
                URLQueryItem(name: "portalId", value: PortalId.TestIdentifier.rawValue)
            ]
        case .KBArticleDetails(let id):
            return [
                URLQueryItem(name: "portalId", value: PortalId.TestIdentifier.rawValue)
            ]
        }
    }
    
    func makeUrl() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseUrl
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        

        guard let url = urlComponents.url else{
            return nil
        }
        return url
        
    }
}

