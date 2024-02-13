//
//  Enum.swift
//  KBDashBoard
//
//  Created by Rajesh R on 12/02/24.
//

import Foundation

enum Response: String{
    case Success = "The Data fetched Successfully"
    case Failure = "Erro, While Fetching Data"
}

enum Language: String{
    case US = "us"
    case EU = "eu"
}

enum QueryParameters: String{
    case isFollow
}

enum PathUrl: String{
    case Base = "https://desk.zoho.com/portal/api/"
    case KBCategories = "kbRootCategories"
}

enum CategoriesIdentifier: String{
    case TestIdentifier = "edbsnace8901b67ed92219428dc84a50ab4f3ed89f4b283f2b51f152bb76c0879a94f"
}



