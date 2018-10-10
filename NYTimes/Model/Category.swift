//
//  Category.swift
//  NYTimes
//

import UIKit
import ObjectMapper

class Category: Mappable {
    var listName : String?
    var displayName : String?
    var listNameEncoded : String?
    var oldestPublishedDate : String?
    var newestPublishedDate : String?
    var updated : String?
    
    required init() {
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        listName <- map["list_name"]
        displayName <- map["display_name"]
        listNameEncoded <- map["list_name_encoded"]
        oldestPublishedDate <- map["oldest_published_date"]
        newestPublishedDate <- map["newest_published_date"]
        updated <- map["updated"]
    }
    
}
