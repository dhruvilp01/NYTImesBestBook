//
//  Constatnts.swift
//  NYTimes
//

import UIKit

struct ConstantsAPI {
    static var BASE_URL = "https://api.nytimes.com/svc/books/v3/"  // Dev URL
    static let FETCH_CATEGORIES = "lists/names.json"
    static let FETCH_BOOKS = "lists.json"
    
}

struct ConstantsParamKeys {
    static let KEY_CAT_NAME = "catName"
}

struct ConstantsGeneral {
    static let ACCEPT = "Accept"
    static let CONTENT_TYPE = "Content-Type"
    static let APP_JSON = "application/json"
}

enum SERVICE_NATURE {
    case POST
    case GET
    case PUT
    case DELETE
    case PATCH
}
