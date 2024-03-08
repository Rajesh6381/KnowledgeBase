//
//  KBStrings.swift
//  KBDashBoard
//
//  Created by Rajesh R on 29/02/24.
//

import Foundation


struct KBStrings{
    
    enum PatternIdentifier: String{
        case ListHeader = "listHeader"
        case ListFooter = "listFooter"
        case SectionHeader = "sectionHeader"
        case SectionFooter = "sectionFooter"
        case CategoryCell = "categoryCell"
        case ArticleCell = "articleList"
    }
    
    enum NavigationKeys: String{
        case NavigationMenuIcon = "navMenuIcon"
        case NavigationBarTitle = "navBarTitle"
        case NavigationBackIcon = "navBackIcon"
        case BottomBarTitle = "bottomBarTitle"
        case LikeButton = "likeButton"
        case DislikeButton = "dislikeButton"
        case MoreButton = "moreButton"
    }
    
    enum SearchBarKeys: String{
        case SearchInput = "searchTextInput"
    }
    
    enum CategoryCellKeys: String{
        case Image = "cellImage"
        case Title = "cellTitle"
        case Description = "cellDescription"
        case Articles = "cellArticles"
        case ArticleTitle = "cellArticleTitle"
        case ArtilceCount = "cellArticleCount"
        case Sections = "cellSections"
        case SectionTitle = "cellSectionTitle"
        case SectionCount = "cellSectionCount"
    }
    
    enum ArticleCellKeys: String{
        case Image = "articleImage"
        case Title = "articleLabel"
    }
    
    enum Actions: String{
        case Backbutton = "backButton"
    }
    
    enum ArticleContainerKeys: String{
        case Title = "articleTitle"
        case WebView = "articleWebView"
        case CreatedDate = "articleCreatedDate"
    }
}

enum ScreenIdentifier: String{
    case KBCategoryScreen = "kbCategoryScreen"
    case KBArticleScreen = "kbArticleListScreen"
    case KBArticleDetailScreen = "kbArticleDetailScreen"
}

enum Icons: String{
    case Menu = "line.3.horizontal"
    case Back = "\u{2039}"
    case Like = "hand.thumbsup"
    case DisLike = "hand.thumbsdown"
    case More = "ellipsis"
    case Image = "photo"
    case Document = "doc.text"
}

enum NavigationStrings: String{
    case BottomBar = "Powered By ASAP"
    case Back = "Back"
    case CategoryTitle = "KnowledgeBase"
    case ArticleTitle = "Articles"
}

enum PlaceHolderString: String{
    case Search = "Search"
}

enum PlainString:String{
    case ArticleCountTitle = "Articles"
    case SectionCountTitle = "Sections"
}
