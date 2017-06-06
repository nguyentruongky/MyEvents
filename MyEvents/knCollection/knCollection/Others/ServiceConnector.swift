//
//  ServiceConnector.swift
//  WorkshopFixir
//
//  Created by Ky Nguyen on 12/28/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
//import Alamofire


//struct ServiceConnector {
//    
//    static fileprivate var connector = AlamofireConnector()
//    
//    static func getHeader() -> [String: String]? {
//        
//        return nil
//    }
//    
//    static func getUrl(from api: String) -> URL {
//        
//        let apiUrl = api.contains("http") ? api : "BASE_URL"
//        return URL(string: apiUrl)!
//    }
//    
//    static func get(_ api: String,
//                    params: [String: Any]? = nil,
//                    success: @escaping (_ result: AnyObject) -> Void,
//                    fail: ((_ error: knError) -> Void)? = nil) {
//        
//        let apiUrl = getUrl(from: api)
//        let header = getHeader()
//        
//        connector.get(apiUrl, params: params, header: header, success: success, fail: fail)
//    }
//    
//    static func put(_ api: String,
//                    params: [String: Any]? = nil,
//                    success: @escaping (_ result: AnyObject) -> Void,
//                    fail: ((_ error: knError) -> Void)? = nil) {
//        let apiUrl = getUrl(from: api)
//        let header = getHeader()
//        
//        connector.put(apiUrl, params: params, header: header, success: success, fail: fail)
//    }
//    
//    static func post(_ api: String,
//                     params: [String: Any]? = nil,
//                     success: @escaping (_ result: AnyObject) -> Void,
//                     fail: ((_ error: knError) -> Void)? = nil) {
//        let apiUrl = getUrl(from: api)
//        let header = getHeader()
//        
//        connector.post(apiUrl, params: params, header: header, success: success, fail: fail)
//    }
//    
//    
//    static func delete(_ api: String,
//                       params: [String: Any]? = nil,
//                       success: @escaping (_ result: AnyObject) -> Void,
//                       fail: ((_ error: knError) -> Void)? = nil) {
//        let apiUrl = getUrl(from: api)
//        let header = getHeader()
//        
//        connector.delete(apiUrl, params: params, header: header, success: success, fail: fail)
//    }
//}
