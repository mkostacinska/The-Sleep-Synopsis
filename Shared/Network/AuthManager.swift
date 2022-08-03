//
//  AuthManager.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 02/08/2022.
//

import Foundation
import KeychainAccess
import JWTDecode

enum AuthError: Error {
    case missingToken, corruptedToken, failedRefresh, invalidToken
}

actor AuthManager {
    private var refreshTask: Task<String, Error>?
    
    func validToken() async throws -> String {
        if let handle = refreshTask {
            return try await handle.value
        }
        
        let keychain = Keychain(service: "online.tomk.The-Sleep-Synopsis")
        guard let token = try keychain.getString("jwt") else {
            throw AuthError.missingToken
        }
        
        guard let jwt = try? decode(jwt: token),
              let exp = jwt.expiresAt else {
            throw AuthError.corruptedToken
        }
        
        if exp >= Date().addingTimeInterval(60) {
            return try await refreshToken()
        }
        
        return token
        
    }
    
    func refreshToken() async throws -> String {
        
        let keychain = Keychain(service: "online.tomk.The-Sleep-Synopsis")
        guard let uuid = try keychain.getString("uuid"),
              let refresh = try keychain.getString("refresh") else {
            throw AuthError.missingToken
        }
        
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }
        
        let task = Task { () throws -> String in
            defer { refreshTask = nil }
            
            
            do {
                if let tokens = await APIClient.shared.refreshTokenRequest(refreshToken: refresh, uuid: uuid) {
                    
                    try keychain.set(tokens.authenticationToken, key: "jwt")
                    try keychain.set(tokens.refreshToken, key: "refresh")
                    
                    return tokens.authenticationToken
                }
                throw AuthError.missingToken
            } catch {
                throw AuthError.failedRefresh
            }
        }
        
        self.refreshTask = task
        return try await task.value
    }
    
}
