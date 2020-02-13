//
//  NetworkRouter.swift
//
//  Created by Florin Adrian Odagiu on 22/01/2020.
//

import Foundation
import Alamofire



enum NetworkRouter: Alamofire.URLRequestConvertible {
    
    
    
    //MARK: - variables
    static let baseURL    = URL(string: "https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com")
    static let pathPrefix = "/test/"
    
    
    
    //MARK: - values
    case authenticate(email: String, password: String)
    //while app gets expanded, this is where I'd enumerate the rest of the network operations
    
    
    
    //MARK: - endpoint method
    var method: HTTPMethod {
        switch self {
            
            //case .something:                  //while app gets expanded, this is where I'd enumerate all the values that require get
            //    return .get
            
            case .authenticate:                 //while app gets expanded, this is where I'd enumerate all the values that require post
                return .post
            
            //case .somethingElse:              //while app gets expanded, this is where I'd enumerate all the values that require put
            //    return .put
            
            //case .somethingElser:             //while app gets expanded, this is where I'd enumerate all the values that require delete
            //    return .delete
        }
    }
    
    
    
    //MARK: - endpoint path
    var path : String {
        switch self {
        case .authenticate:
            return "authenticate"
            //while app gets expanded, continue enumerating
        }
    }
    
    
    
    //MARK: - endpoint parameters
    var parameters: Parameters? {
        switch self {
        case .authenticate(let mail, let psw):
            return [
                "email"   : mail,
                "password": psw,
            ]
            //while app gets expanded, continue enumerating
        }
    }
    
    
    
    //MARK: - URLRequestConvertible protocol
    func asURLRequest() throws -> URLRequest {
        
        let urlValue = NetworkRouter.baseURL?.appendingPathComponent(NetworkRouter.pathPrefix + self.path)
        
        var urlRequest = URLRequest(url: urlValue!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json"              , forHTTPHeaderField: "Accept")
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        
        print("url: \(urlRequest.url!)")
        
        return urlRequest
    }
    
}
