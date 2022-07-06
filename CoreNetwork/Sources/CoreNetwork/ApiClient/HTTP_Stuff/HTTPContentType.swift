//
//  HTTPContentType.swift
//  
//
//  Created by polykuzin on 06/07/2022.
//

import Foundation

public enum HTTPContentType : String {
    case json = "application/json"
    case formData = "multipart/form-data;"
    case urlEncoded = "application/x-www-form-urlencoded"
}
