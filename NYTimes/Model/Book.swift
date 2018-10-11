//
//  Category.swift
//  NYTimes
//

import UIKit
import Realm
import RealmSwift
import ObjectMapper

class Book: Object, Mappable {
    @objc dynamic var category = ""
    @objc dynamic var title = ""
    @objc dynamic var bookDesc = ""
    @objc dynamic var contributor = ""
    @objc dynamic var author = ""
    @objc dynamic var publisher = ""
    @objc dynamic var rank : Int = 0
    @objc dynamic var noOfWeeksOnList : Int = 0
    @objc dynamic var amazonURL = ""
    @objc dynamic var reviewURL = ""
    
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
        title <- map["title"]
        bookDesc <- map["description"]
        contributor <- map["contributor"]
        author <- map["author"]
        publisher <- map["publisher"]
        rank <- map["rank"]
        noOfWeeksOnList <- map["weeks_on_list"]
        amazonURL <- map["amazon_product_url"]
        reviewURL <- map["book_review_link"]
    }
}
