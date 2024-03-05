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

enum NetworkError: Error{
    case UnableGenerateURL
    case InvalidEndPoint
    case ParsingError
}

enum PortalId: String{
    case TestIdentifier = "edbsnace8901b67ed92219428dc84a50ab4f3ed89f4b283f2b51f152bb76c0879a94f"
}

enum StoryBoardIdentifier:String{
    case ArticleCategoryStroyBoard, ArticleList, ArticleDetailsStoryBoard
}



