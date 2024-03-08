//
//  KBCategoryProvider.swift
//  KBDashBoard
//
//  Created by Rajesh R on 27/02/24.
//

import Foundation
import ZohoDeskPlatformDataBridge

//PROVIDER
class KBCategoryProvider: ZDBinderProtcol{
    func getDetailDataSource(_ identifier: String) -> ZohoDeskPlatformDataBridge.ZBDetailProtocol? {
        return nil
    }
    
    func getReplayDataSource(_ identifier: String) -> ZohoDeskPlatformDataBridge.ZBReplyProtocol?
    {
        return nil
    }
    
    func getListDataSource(_ identifier: String) -> ZohoDeskPlatformDataBridge.ZBListProtocol? {
        return KBCategoryListBinder(path: .KBRootCategories)
    }
    
    func getChatDataSource(_ identifier: String) -> ZohoDeskPlatformDataBridge.ZBChatProtocol? {
        return nil
    }
    
    func prepareBuilderJSONS(onCompletion: @escaping (([Data]) -> Void)) {
        var listData = [Data]()
        let jsonFiles = ["KBCategory","KBStyles","KBCommon"]
        jsonFiles.forEach({ fileName in
           guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url) else{
                return
            }
            listData.append(data)
        })
        onCompletion(listData)
    }
}


