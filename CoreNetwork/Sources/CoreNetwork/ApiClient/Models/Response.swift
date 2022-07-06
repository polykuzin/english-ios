//
//  Response.swift
//  
//
//  Created by polykuzin on 06/07/2022.
//

import Foundation

public struct Response<T> {
    // Original data
    public let data : Data
    public let value : T
    public let success : Bool
    public let statusCode : Int
}
