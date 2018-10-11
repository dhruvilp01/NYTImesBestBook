//
//  Category.swift
//  NYTimes
//

import UIKit
import Realm
import RealmSwift
import ObjectMapper

class Category: Object, Mappable {
    @objc dynamic var listName = ""
    @objc dynamic var displayName = ""
    @objc dynamic var listNameEncoded = ""
    @objc dynamic var oldestPublishedDate = ""
    @objc dynamic var newestPublishedDate = ""
    @objc dynamic var updated = ""
    
    required init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    func mapping(map: Map) {
        listName <- map["list_name"]
        displayName <- map["display_name"]
        listNameEncoded <- map["list_name_encoded"]
        oldestPublishedDate <- map["oldest_published_date"]
        newestPublishedDate <- map["newest_published_date"]
        updated <- map["updated"]

    }
    
}
