//
//  KBBase.swift
//  KBDashBoard
//
//  Created by Rajesh R on 06/03/24.
//

import Foundation
import ZohoDeskPlatformDataBridge

class KBBase{
    
    func navPrepareData(elements: [ZBDataItem],title: String,likeCount: String?,dislikeCount: String?) -> [ZBDataItem] {
        elements.forEach({data in
            print("key \(data.key)")
            switch KBStrings.NavigationKeys(rawValue: data.key){
                case .NavigationBackIcon:
                    data.value.attributedString = attributedImageString(str: NavigationStrings.Back.rawValue, image: Icons.Back.rawValue)
                case .NavigationBarTitle:
                    data.value.plainString = title
                case .NavigationMenuIcon:
                    data.imageValue.image = UIImage(systemName: Icons.Menu.rawValue)
                case .BottomBarTitle:
                    data.value.plainString = NavigationStrings.BottomBar.rawValue
                case .LikeButton:
                    data.imageValue.image =  UIImage(systemName: Icons.Like.rawValue)
                    data.value.plainString =  likeCount
                case .DislikeButton:
                    data.imageValue.image = UIImage(systemName: Icons.DisLike.rawValue)
                    data.value.plainString = dislikeCount
                case .MoreButton:
                    data.imageValue.image = UIImage(systemName: Icons.More.rawValue)
                default :
                    print("default navigation bar")
            
            }})
        return elements
    }
    
    func searchDataItem(elements: [ZBDataItem]) -> [ZBDataItem]{
        elements.forEach({ data in
            switch KBStrings.SearchBarKeys(rawValue: data.key){
                case .SearchInput:
                    data.value.placeHolderString = PlaceHolderString.Search.rawValue
                case .none:
                    print("None in search Bar")
            }
        })
        return elements
    }
    
    func backNavigation(key: String,do onCompletion: @escaping ((ZBCoreBridgeBinderProtocols<Any>?, ZPVoidCompletion?) -> Void)){
        switch KBStrings.Actions(rawValue: key){
            case .Backbutton:
            onCompletion(nil,nil)
        default:
            print("default cases")
        }
    }
    
}

extension KBBase{
    func attributedImageString(str: String,image: String) -> NSAttributedString{
        let fullString = NSMutableAttributedString(string: "")
        let backArrowString = NSAttributedString(string: image, attributes: [
                    .font: UIFont.systemFont(ofSize: 40),
                    .foregroundColor: UIColor.white,
                    .baselineOffset: NSNumber(value: 15)
                ])
        fullString.append(backArrowString)
        fullString.append(NSAttributedString(string: str,attributes: [.baselineOffset: NSNumber(value: 20)]))
        
        return fullString
    }
}
