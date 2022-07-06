//
//  AnyEncodable.swift
//  
//
//  Created by polykuzin on 06/07/2022.
//

import Foundation

public struct AnyEncodable : Encodable {

    public init(_ value: Encodable) {
        self.value = value
    }

    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
    
    private let value : Encodable
}
