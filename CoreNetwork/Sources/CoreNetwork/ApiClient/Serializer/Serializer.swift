//
//  Serializer.swift
//  
//
//  Created by polykuzin on 06/07/2022.
//

import Foundation

public actor Serializer {
    
    private let decoder : JSONDecoder
    private let encoder : JSONEncoder
    
    public func decode<T: Decodable>(_ data: Data) async throws -> T {
        try decoder.decode(T.self, from: data)
    }
    
    public func encode<T: Encodable>(_ value: T) async throws -> Data {
        try encoder.encode(value)
    }
    
    public init(decoder: JSONDecoder = JSONDecoder(), encoder: JSONEncoder = JSONEncoder()) {
        self.decoder = decoder
        self.encoder = encoder
    }
}
