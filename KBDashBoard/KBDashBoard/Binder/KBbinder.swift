//
//  KBbinder.swift
//  KBDashBoard
//
//  Created by Rajesh R on 29/02/24.
//

import Foundation
import ZohoDeskPlatformDataBridge

class KBbinder: ZBListProtocol{
    var navigationIdentifier: String
    
    
    var loadingIndicator: ((ZPLoaderProgress) -> Void)?
    var dbNotifier: ((ZDListFetchedResultUpdate?) -> Void)?
    var handler: ((ZDListUpdate?) -> Void)?
    
    init(identifier: ScreenIdentifier){
        self.navigationIdentifier = identifier.rawValue
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return 1
    }
    
    func doPerform(builderAction action: ZPUIBuilderAction, onCompletion: @escaping ((ZBCoreBridgeBinderProtocols<Any>?, ZPVoidCompletion?) -> Void)) {
        switch action{
            case .general(.target(let key)):
                switch KBStrings.Actions(rawValue: key ?? ""){
                    case .Backbutton:
                        
                        onCompletion(nil,nil)
                    default:
                        print("no cases")
                }
            default :
                print("nothing")
        }
    }
    
    var canLoadMore: Bool = false
    
    func initialize(onCompletion: @escaping ((ZohoDeskPlatformDataBridge.ZPIntializeProgress) -> Void)) {
        onCompletion(.success)
    }
    
    func downloadData(fromUrl url: String, onComplete complete: @escaping ((ZPImageHandlerType) -> Void)) {
        guard let imageUrl = URL(string: url) else {
                    return
        }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let imageData = data {
                        if url.lowercased().hasSuffix(".svg"){
                            complete(.preview(data: imageData, ofType: .svg, conditionalStyleValue: ""))
                        }else{
                            complete(.preview(data: imageData, ofType: .img, conditionalStyleValue: ""))
                        }
                    }
        }.resume()
    }
    
    func render(basedOn patternType: ZDPatternType) -> String? {
        print(patternType)
        switch patternType{
            case .listHeader:
                return KBStrings.PatternIdentifier.ListHeader.rawValue
            case .listFooter:
                return KBStrings.PatternIdentifier.ListFooter.rawValue
            case .sectionHeader(_):
                return KBStrings.PatternIdentifier.SectionHeader.rawValue
            case .sectionFooter(_):
                return KBStrings.PatternIdentifier.SectionFooter.rawValue
            default:
                return ""
        }
    }
    
    func handle(loaderCompletion: ((ZPLoaderProgress) -> Void)?) {
        loadingIndicator = loaderCompletion
    }
    
    func updateUI(_ defaultCompletion: ((ZDListUpdate?) -> Void)?, _ dbFetchCompletion: ((ZDListFetchedResultUpdate?) -> Void)?) {
        handler = defaultCompletion
        dbNotifier = dbFetchCompletion
    }
    
    
    func prepareData(of dataSourceType: ZohoDeskPlatformDataBridge.ZBDataSourceType) -> [ZohoDeskPlatformDataBridge.ZBDataItem] {
        switch dataSourceType{
            
        case .navigation(.getElement(let elements)):
            elements.forEach({data in
                data.valueUpdation
                switch KBStrings.NavigationKeys(rawValue: data.key){
                    case .NavigationBackIcon:
                        data.value.attributedString = attributedImageString(str: "Back", image: "\u{2039}")
                    case .NavigationBarTitle:
                    data.value.conditionalValue = "clicked"
                        data.value.plainString = "Knowledge Base"
                    case .NavigationMenuIcon:
                        data.imageValue.image = UIImage(systemName: "line.3.horizontal")
                    case .none:
                        print("none Nvigation Bar")
                }})
            return elements
        case .search(.getElement(let elements)):
            elements.forEach({ data in
                
                switch KBStrings.SearchBarKeys(rawValue: data.key){
                    case .SearchInput:
                        data.value.placeHolderString = "Search"
                    case .none:
                        print("None in search Bar")
                }
            })
            return elements
        default :
            print("default cases")
            return []
        }
    }
    
    var performAction: (() -> ())?
    
    
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



