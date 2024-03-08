//
//  KBbinder.swift
//  KBDashBoard
//
//  Created by Rajesh R on 29/02/24.
//

import Foundation
import ZohoDeskPlatformDataBridge

class KBListBinder: KBBase, ZBListProtocol{
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
                backNavigation(key: key ?? "", do: onCompletion)
            default :
                print("nothing")
        }
    }
    
    var canLoadMore: Bool = false
    
    func initialize(onCompletion: @escaping ((ZohoDeskPlatformDataBridge.ZPIntializeProgress) -> Void)) {
        onCompletion(.success)
        loadingIndicator?(.begin)
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
        case .search(.getElement(let elements)):
           return searchDataItem(elements: elements)
        default :
            print("default cases")
            return []
        }
    }
    
    var performAction: (() -> ())?
    
    

}



