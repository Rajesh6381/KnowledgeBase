//
//  ViewController.swift
//  KBDashBoard
//
//  Created by zoho on 09/02/24.
//

import UIKit
import ZohoDeskPortalKB
import ZohoDeskPlatformUIKit





class SelectPlatformViewController: CommonViewController ,ZDPConfigurationDelegate{

   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func nativeKB(_ sender: Any) {
        let path =  KBCategoryPath.KBRootCategories
        let controller = Navigation.KBCategories(categories: nil, kbPath: path, identifier: .ArticleCategoryStroyBoard)
        self.navigate(navigation: controller, with: .push)
        
    }
    @IBAction func platformKBActions(_ sender: Any) {
        
        let builder = ZDPBuilderSDK(initial: "kbCategoryScreen", includeBinder: KBCategoryProvider()) { controller in
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        builder.overrideColors(colorId: ColorIDs.ThemeColor.rawValue)
        builder.overrideColors(colorId: ColorIDs.BGColor.rawValue)
        builder.overrideColors(colorId: ColorIDs.WidgetColor.rawValue)
        builder.overrideColors(colorId: ColorIDs.HeaderColor.rawValue)
        builder.overrideColors(colorId: ColorIDs.PrimaryText.rawValue)
        builder.overrideColors(colorId: ColorIDs.SecondaryText.rawValue)
        builder.overrideColors(colorId: ColorIDs.PlaceholderText.rawValue)
        builder.overrideColors(colorId: ColorIDs.IconColor.rawValue)
        builder.overrideColors(colorId: ColorIDs.FieldBorderColor.rawValue)
        builder.overrideColors(colorId: ColorIDs.SeparatorColor.rawValue)
        builder.overrideColors(colorId: ColorIDs.White.rawValue)
        builder.overrideColors(colorId: ColorIDs.NavStyleColor.rawValue)
        builder.overrideColors(colorId: ColorIDs.ShadowColor.rawValue)
    }
    
}

enum ColorIDs: String{
    case ThemeColor,BGColor,WidgetColor,HeaderColor,PrimaryText,SecondaryText,PlaceholderText,IconColor,FieldBorderColor,SeparatorColor,White,NavStyleColor,ShadowColor
}




