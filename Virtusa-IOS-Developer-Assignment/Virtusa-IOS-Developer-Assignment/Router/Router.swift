//
//  Router.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 13/04/22.
//

import Foundation

protocol asURLRequestComposer {
    func asURLRequest() -> URLRequest?
}

public enum Router:asURLRequestComposer {
  
    public static let baseURLString = UserDefaults.standard.string(forKey: "environment_id") ?? "https://61e947967bc0550017bc61bf.mockapi.io"
    static let baseAPIFolder = "/api/v1"
    
    case people
    case rooms
    
    var method: HTTPMethod {
        switch self {
        case  .people:
            return .get
        case  .rooms:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case  .people:
            return "/people"
        case  .rooms:
            return "/rooms"
        }
    }
   
    public func asURLRequest() -> URLRequest? {
        let url = Foundation.URL(string: Router.baseURLString + Router.baseAPIFolder)!
        var ulrRequest = URLRequest(url: url.appendingPathComponent(path))
        ulrRequest.httpMethod = method.rawValue
        return ulrRequest
    }
}
