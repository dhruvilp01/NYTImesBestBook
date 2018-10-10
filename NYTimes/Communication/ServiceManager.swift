//
//  ServiceManager.swift
//  NYTimes
//

import Foundation
import Alamofire
import AlamofireImage
import ObjectMapper

class ServiceManager: NSObject {
    static let sharedInstance = ServiceManager()
    
    func instantiateServiceWithServiceParams(alertHandler:AnyObject, serviceType:String, serviceInputs:NSMutableDictionary,  serviceNature:SERVICE_NATURE, encodingVal:ParameterEncoding, withSuccess successBlock: @escaping (Any?) -> Void, withFailure errorBlock: @escaping (Error?,HTTPURLResponse?) -> Void){
        var urlFinal : String = ConstantsAPI.BASE_URL + serviceType
        urlFinal += "?api-key=c7bf1ce3452c48d88c56a00d72d71359"
        
        var header : HTTPHeaders = [ConstantsGeneral.CONTENT_TYPE:ConstantsGeneral.APP_JSON]
        header[ConstantsGeneral.ACCEPT] = ConstantsGeneral.APP_JSON
        switch serviceType {
        case ConstantsAPI.FETCH_CATEGORIES:
            print("FETCH_CATEGORIES")
        case ConstantsAPI.FETCH_BOOKS:
            let cat : String =  serviceInputs.value(forKey: ConstantsParamKeys.KEY_CAT_NAME)! as! String
            urlFinal += "&list=" + cat
            print("FETCH_BOOKS")
        default:
            print("Default option")
        }
        urlFinal = urlFinal.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
        Alamofire.request(urlFinal, method: ServiceManager().getNatureOfService(serviceNature), parameters: serviceNature == .GET ? nil : serviceInputs as? Parameters, encoding: encodingVal, headers: header).validate(statusCode: 200..<300).responseJSON(completionHandler: {response in
            print(request)
            print(response)
            switch response.result {
            case .success(let data):
                successBlock(data)
            case .failure(let error):
                errorBlock(error,response.response);
            }
        })
    }
    
    func getNatureOfService(_ serviceNature:SERVICE_NATURE)->HTTPMethod{
        var natureOfService:HTTPMethod = .get
        switch serviceNature{
        case SERVICE_NATURE.POST:
            natureOfService = .post
        case SERVICE_NATURE.GET:
            natureOfService = .get
        case SERVICE_NATURE.PUT:
            natureOfService = .put
        case SERVICE_NATURE.DELETE:
            natureOfService = .delete
        case SERVICE_NATURE.PATCH:
            natureOfService = .patch
        }
        return natureOfService
    }
}

