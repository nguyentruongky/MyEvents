//
//  AlamofireConnector.swift
//  WorkshopFixir
//
//  Created by Ky Nguyen on 12/28/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
//import Alamofire
//
//struct AlamofireConnector {
//    
//    
//    func get(_ api: URL,
//             params: [String: Any]? = nil,
//             header: [String: String]? = nil,
//             success: @escaping (_ result: AnyObject) -> Void,
//             fail: ((_ error: knError) -> Void)?) {
//        
//        request(withApi: api, method: .get, params: params, header: header, success: success, fail: fail)
//    }
//    
//    private func request(withApi api: URL,
//                 method: HTTPMethod,
//                 params: [String: Any]? = nil,
//                 header: [String: String]? = nil,
//                 success: @escaping (_ result: AnyObject) -> Void,
//                 fail: ((_ error: knError) -> Void)?) {
//        
//
//        Alamofire.request(api, method: method, parameters: params, encoding: URLEncoding.httpBody, headers: header)
//        .responseJSON { (response) in
//            
//            print("===Request: \(String(describing: response.request?.url))")
//            
//            if self.isPhysicalFailure(response: response) {
//                print(response)
//                fail?(knError(code: .timeOut, message: response.result.error!.localizedDescription))
//                print("===Error: \(response.result.error!.localizedDescription)")
//                return
//            }
//            
//            if let error = self.isLogicalFailure(response: response.result.value as AnyObject) {
//                print("===Error: \(String(describing: error.message))")
//                fail?(error)
//                return
//            }
//            
//            print("===Response: \(response.result.value!)")
//            success(response.result.value! as AnyObject)
//        }
//    }
//    
//    private func isPhysicalFailure(response: DataResponse<Any>) -> Bool {
//        return response.result.error != nil
//    }
//    
//    private func isLogicalFailure(response: AnyObject) -> knError? {
//
//        let error = JSONParser.getBool(forKey: "error", inObject: response)
//        if error == true {
//            let message = JSONParser.getString(forKey: "msg", inObject: response)
//            return knError(code: .notSure, message: message)
//        }
//        return nil
//    }
//    
//    func put(_ api: URL,
//             params: [String: Any]? = nil,
//             header: [String: String]? = nil,
//             success: @escaping (_ result: AnyObject) -> Void,
//             fail: ((_ error: knError) -> Void)?) {
//        
//        request(withApi: api, method: .put, params: params, header: header, success: success, fail: fail)
//    }
//    
//    func post(_ api: URL,
//              params: [String: Any]? = nil,
//              header: [String: String]? = nil,
//              success: @escaping (_ result: AnyObject) -> Void,
//              fail: ((_ error: knError) -> Void)?) {
//        
//        request(withApi: api, method: .post, params: params, header: header, success: success, fail: fail)
//    }
//    
//    
//    func delete(_ api: URL,
//                params: [String: Any]? = nil,
//                header: [String: String]? = nil,
//                success: @escaping (_ result: AnyObject) -> Void,
//                fail: ((_ error: knError) -> Void)?) {
//        
//        request(withApi: api, method: .delete, params: params, header: header, success: success, fail: fail)
//    }
//    
//    
//    
//    
//}
