//
//  APIClientDelegate.swift
//
//
//  Created by polykuzin on 06/07/2022.
//

import Foundation

public enum RetryPolicy {
    case shouldRetry
    case doNotRetry
    case doNotRetryWith(APIError)
}

public protocol APIClientInterceptor {
    
    func client(_ client: ApiClient, willSendRequest request: inout URLRequest)
    
    func client(_ client: ApiClient, initialRequest: Request, didReceiveInvalidResponse response: HTTPURLResponse, data: Data?) async -> RetryPolicy
}

public final class DefaultAPIClientInterceptor : APIClientInterceptor {
    
    public func client(_ client: ApiClient, willSendRequest request: inout URLRequest) { }
    
    public func client(_ client: ApiClient, initialRequest: Request, didReceiveInvalidResponse response: HTTPURLResponse, data: Data?) async -> RetryPolicy {
        return .doNotRetry
    }
}
