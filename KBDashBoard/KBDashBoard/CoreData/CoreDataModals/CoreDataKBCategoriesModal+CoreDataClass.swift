//
//  CoreDataKBCategoriesModal+CoreDataClass.swift
//  
//
//  Created by Rajesh R on 22/02/24.
//
//

import Foundation
import CoreData

@objc(CoreDataKBCategoriesModal)
public class CoreDataKBCategoriesModal: NSManagedObject {

    public override var description: String{
        set{
            categoriesDescription = newValue
        }
        get{
            return categoriesDescription ?? ""
        }
    }
    
}
