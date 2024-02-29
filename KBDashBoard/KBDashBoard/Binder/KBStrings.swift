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
}
