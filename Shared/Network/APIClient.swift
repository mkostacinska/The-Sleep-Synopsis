//
//  APIClient.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 02/08/2022.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case connect = "CONNECT"
}

struct HttpHeader {
    
    let field: String
    let value: String
}

struct APIRequest {
    
    let method: HttpMethod
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [HttpHeader]?
    var body: Data?
    var contentType: String = "application/json"
    
    init(method: HttpMethod, path: String) {
        self.method = method; self.path = path
    }
}

class APIClient {
    
    #if DEBUG
    private let BASEURL = "https://api-dev.tss.tomk.online/"
    #else
    private let BASEURL = "https://api.tss.tomk.online/"
    #endif
    
    public static let shared = APIClient()
    
    private var isRefreshing: Bool = false
    private var authManager: AuthManager = AuthManager()
    
//    static func perform<T: Decodable>(url: String, to type: T.Type) async throws -> T? {
//        let
//    }
    
    func refreshTokenRequest(refreshToken: String, uuid: String) async -> UserAuthenticationTokens? {
        guard let baseURL = URL(string: BASEURL),
              let url = "auth/refresh".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: url, relativeTo: baseURL) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = RefreshTokenDTO(userUUID: uuid, refreshToken: refreshToken).jsonEncode() ?? Data()
        
        do {
            let (data, request) = try await URLSession.shared.data(for: urlRequest)
            if let httpRequest = request as? HTTPURLResponse {
                print(httpRequest.statusCode)

            }
            return try data.decode(to: UserAuthenticationTokens.self)
        } catch {
            print("***: \(error.localizedDescription)")
            return nil
        }
    }
    
    func perform<T: Decodable>(_ request: APIRequest, to type: T.Type) async throws -> T? {
        let data = await performNoDecoding(request)
        guard let data = data else {
            return nil
        }
        
        return try data.decode(to: T.self)
    }
    
    func performNoDecoding(_ request: APIRequest, allowRetry: Bool = true) async -> Data? {
        
        guard let baseURL = URL(string: BASEURL),
              let url = request.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: url, relativeTo: baseURL) else {
            return nil
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(request.contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let token = try? await authManager.validToken() {
            print("adding token")
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        print(urlRequest.url?.absoluteString ?? "")
        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                return nil
            }
            
            if httpResponse.statusCode == 401 {
                if allowRetry {
                    _ = try await authManager.refreshToken()
                    return await performNoDecoding(request, allowRetry: false)
                }
                
                throw AuthError.invalidToken
            }
            
            return data
        } catch {
            print("**: " + String(describing: error))
            return nil
        }
    }
    
}
