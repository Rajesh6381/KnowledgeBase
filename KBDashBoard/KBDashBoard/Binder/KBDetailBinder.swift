//
//  KBDetailBinder.swift
//  KBDashBoard
//
//  Created by Rajesh R on 06/03/24.
//

import Foundation
import ZohoDeskPlatformDataBridge

class KBDetailBinder:KBBase, ZBDetailProtocol{
    
    var navigationIdentifier: String
    var loadingView: ((ZPLoaderProgress) -> Void)?
    var updateView: ((ZDDetailUpdate?) -> Void)?
    
    func handle(loaderCompletion: ((ZPLoaderProgress) -> Void)?) {
        self.loadingView = loaderCompletion
    }
    
    func updateUI(_ onCompletion: ((ZDDetailUpdate?) -> Void)?) {
        updateView = onCompletion
    }
    
    init(identifier: ScreenIdentifier){
        self.navigationIdentifier = identifier.rawValue
    }
    
    func initialize(onCompletion: @escaping ((ZohoDeskPlatformDataBridge.ZPIntializeProgress) -> Void)) {
        onCompletion(.success)
        loadingView?(.begin)
    }
    
    
    
    func prepareData(of dataSourceType: ZohoDeskPlatformDataBridge.ZBDataSourceType) -> [ZohoDeskPlatformDataBridge.ZBDataItem] {
        return []
    }
    
    func doPerform(builderAction action: ZPUIBuilderAction, onCompletion: @escaping ((ZBCoreBridgeBinderProtocols<Any>?, ZPVoidCompletion?) -> Void)) {
        switch action{
        case.general(.target(let key)):
            backNavigation(key: key ?? "",do: onCompletion)
        default:
            print("cases")
        }
    }
    
    var performAction: (() -> ())?
    
    
}
