//
//  Category.swift
//  NYTimes
//

import UIKit
import ObjectMapper

class Book: Mappable {
    var title : String?
    var bookDesc : String?
    var contributor : String?
    var author : String?
    var publisher : String?
    var rank : Int?
    var noOfWeeksOnList : Int?
    var amazonURL : String?
    
    required init() {
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        title <- map["title"]
        bookDesc <- map["description"]
        contributor <- map["contributor"]
        author <- map["author"]
        publisher <- map["publisher"]
        rank <- map["rank"]
        noOfWeeksOnList <- map["weeks_on_list"]
        amazonURL <- map["amazon_product_url"]
    }
}
