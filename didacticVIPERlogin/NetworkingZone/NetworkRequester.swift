//
//  NetworkRequester.swift
//
//  Created by Florin Adrian Odagiu on 22/01/2020.
//

import Foundation
import Alamofire

class NetworkRequester {
    
    //MARK: - the raw request
    fileprivate static func performAlamofireRequestWith(
        route: URLRequestConvertible,
        endOfRequestClosure: @escaping (_ payload: Dictionary<String, Any>?, _ somethingWentWrong: String?) -> ()
        )
    {
        AF.request(route)
            .responseJSON { response in
                
                print("request for route: \(route)")
                print("response.response.statusCode: \(String(describing: response.response?.statusCode))")
                
                switch response.result {
                    
                    case .success(let value):
                        let responseDict = value as! Dictionary<String, Any>
                        if response.response!.statusCode == 200 {
                            endOfRequestClosure(responseDict, nil)                                //all good; move data along
                        } else {
                            endOfRequestClosure(nil, responseDict["message"] as? String)          //some server error; move it along
                        }                                                                         //stuff like "401: It's for 40% chance password is wrong!" or "500: It's just a 10% chance to catch a 500 error" or similar
                    
                    case .failure(let error):
                        endOfRequestClosure(nil, error.localizedDescription)                      //some client error; move it along
                                                                                                  //stuff like "The Internet connection appears to be offline" or similar
                }
        }
        
    }
    
    
    
    //MARK: - app_specific requests (only one in this case)
    static func requestAuthentication(
        email: String,
        password: String,
        jobDone: @escaping (_ payload: Dictionary<String, Any>?, _ somethingWentWrong: String?) -> ()
        )
    {
        
        let route = NetworkRouter.authenticate(email: email, password: password)
        
        performAlamofireRequestWith(route: route) { payload, wentWrong in
            if payload != nil {
                jobDone(payload, nil)
            } else {
                jobDone(nil, wentWrong)
            }
        }
        
    }
    
}
