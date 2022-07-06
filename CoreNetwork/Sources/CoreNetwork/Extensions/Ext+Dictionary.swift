//
//  Ext+Dictionary.swift
//
//
//  Created by polykuzin on 06/07/2022.
//

import Foundation

extension Dictionary {
    
    public var queryString: String {
        var output: String = ""
        forEach({ output += "\($0.key)=\($0.value)&"})
        output = String(output.dropLast())
        return output
    }
}
