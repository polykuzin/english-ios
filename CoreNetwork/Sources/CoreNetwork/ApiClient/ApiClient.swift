//
//  ApiClient.swift
//
//
//  Created by polykuzin on 06/07/2022.
//

import Foundation

public actor ApiClient {
    internal let host : String
    internal let session : URLSession
    internal let interceptor : APIClientInterceptor
    internal let httpProtocol : HTTPProtocol
    internal let serializer: Serializer?
    internal let debug: Bool
    
    public init(
        host: String,
        debug: Bool = false,
        serializer: Serializer? = nil,
        interceptor: APIClientInterceptor? = nil,
        httpProtocol: HTTPProtocol = .HTTPS,
        configuration: URLSessionConfiguration = .default
    ) {
        self.host = host
        self.debug = debug
        self.session = URLSession(configuration: configuration)
        self.serializer = serializer
        self.interceptor = interceptor ?? DefaultAPIClientInterceptor()
        self.httpProtocol = httpProtocol
    }
    
    @discardableResult
    public func send(_ request: Request) async throws -> Response<Void>  {
        let (data,statusCode) = try await self.actualSend(request)
        return Response(data: data, value: (), success: true, statusCode: statusCode)
    }
    
    @discardableResult
    public func send<T: Decodable>(_ request: Request) async throws -> Response<T>  {
        let (data,statusCode) = try await self.actualSend(request)
        guard let serializer = serializer else {
            throw APIError.badMapping
        }

        let decoded: T = try await serializer.decode(data)
        return Response(data: data, value: decoded, success: true, statusCode: statusCode)
    }
    
    private func actualSend(_ request: Request) async throws -> (data: Data, statusCode: Int) {
        let url = try makeURL(path: request.path, query: request.query)
        var urlRequest = try await makeURLRequest(url: url, request: request)
        if debug {
            print("🚧🚧🚧 MAKING URL REQUEST:\n\(urlRequest.url?.absoluteString ?? "empty URL")\n")
        }
        interceptor.client(self, willSendRequest: &urlRequest)
        print("📭📭📭 CORENETWORK: started network call")
        if debug {
            print(urlRequest.cURL(pretty: true))
        }
        let (data,response) = try await session.data(from: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.badData
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            print("📭📭📭 CORENETWORK: Did receive error \(httpResponse.statusCode)")
            let retryPolicy = await self.interceptor.client(self, initialRequest: request, didReceiveInvalidResponse: httpResponse, data: data)
            switch retryPolicy {
            case .shouldRetry:
                print("📭📭📭 CORENETWORK: Retrying request \(request.path)")
                let resendedResponse = try await self.actualSend(request)
                return resendedResponse
            case .doNotRetry:
                print("📭📭📭 CORENETWORK: Request marked as do not retry")
                throw APIError.unacceptableStatusCode(httpResponse.statusCode)
            case .doNotRetryWith(let retryError):
                throw retryError
            }
        } else {
            return (data: data, statusCode: httpResponse.statusCode)
        }
    }
}

extension ApiClient {
    
    public func makeURLRequest(url: URL, request: Request) async throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if let body = request.body {
            urlRequest.setValue(request.contentType.rawValue, forHTTPHeaderField: "Content-Type")
            switch request.contentType {
            case .json:
                let encodedData = try await serializer?.encode(body)
                urlRequest.httpBody = encodedData
            case .formData:
                break
            case .urlEncoded:
                let encoder = URLEncodedFormEncoder()
                let data: Data? = try? encoder.encode(body)
                urlRequest.httpBody = data
            }
        }
        return urlRequest
    }
    
    private func makeURL(path: String, query: [String: String]?) throws -> URL {
        guard
            let url = URL(string: path),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            throw URLError(.badURL)
        }
        if path.starts(with: "/") {
            components.scheme = self.httpProtocol.rawValue
            components.host = host
        }
        if let query = query {
            components.queryItems = query.map(URLQueryItem.init)
        }
        guard
            let url = components.url
        else {
            throw URLError(.badURL)
        }
        return url
    }
}
