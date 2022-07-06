//
//  Request.swift
//  
//
//  Created by polykuzin on 06/07/2022.
//

import Foundation

public struct Request {
    
    public let path : String
    public let body : AnyEncodable?
    public let query : [String: String]?
    public let method : HTTPMethod
    public let contentType : HTTPContentType
    
    public init(path: String, method: HTTPMethod, contentType: HTTPContentType, query: [String: String]? = nil) {
        self.body = nil
        self.path = path
        self.query = query
        self.method = method
        self.contentType = contentType
    }
    
    public init<T: Encodable>(path: String, method: HTTPMethod, contentType: HTTPContentType, query: [String: String]? = nil, body: T?) {
        self.path = path
        self.body = AnyEncodable(body)
        self.query = query
        self.method = method
        self.contentType = contentType
    }
}

public extension Request {
    
    static func POST(path: String, contentType: HTTPContentType) -> Request {
        return Request(path: path, method: .POST, contentType: contentType)
    }
    
    static func GET(path: String, query: [String:String]? = nil) -> Request {
        return Request(path: path, method: .GET, contentType: .json, query: query)
    }
    
    static func PUT(path: String, query: [String:String]? = nil) -> Request {
        return Request(path: path, method: .PUT, contentType: .json, query: query)
    }
    
    static func DELETE(path: String, query: [String:String]? = nil) -> Request {
        return Request(path: path, method: .DELETE, contentType: .json, query: query)
    }
    
    static func POST<T: Encodable>(path: String, body: T?, contentType: HTTPContentType) -> Request {
        return Request(path: path, method: .POST, contentType: contentType, body: body)
    }
}
