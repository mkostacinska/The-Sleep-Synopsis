//
//  AuthService.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 02/08/2022.
//

import Foundation
import KeychainAccess

/// Methods containing Authentication calls to the TSS API
public struct AuthService {
    
    
    /// Attempts to authenticate a user with the specified email/username and password
    /// This method will automatically store the JWT/refresh tokens and the user's uuid in Keychain, and notify GobalData.shared
    /// - Parameters:
    ///   - userAuthenticator: The email or username to login with
    ///   - password: The password to login with
    /// - Returns: A valid User object if the login was successful
    public static func Login(userAuthenticator: String, password: String) async -> User? {
        do {
            var request = APIRequest(method: .post, path: "auth")
            request.body = UserLoginRequest(userAuthString: userAuthenticator, userPass: password).jsonEncode()
            let user = try await APIClient.shared.perform(request, to: User.self)
            
            if let user = user {
                let keychain = Keychain(service: "online.tomk.The-Sleep-Synopsis")
                try? keychain.set(user.userUUID ?? "", key: "uuid")
                try? keychain.set(user.authTokens?.refreshToken ?? "", key: "refresh")
                try? keychain.set(user.authTokens?.authenticationToken ?? "", key: "jwt")
                GlobalData.shared.SetCurrentUser(to: user)
            }
            
            return user
        } catch {
            print("Error logging in \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Removes user information from Keychain
    public static func Logout() {
        let keychain = Keychain(service: "online.tomk.The-Sleep-Synopsis")
        try? keychain.remove("uuid")
        try? keychain.remove("refresh")
        try? keychain.remove("jwt")
        GlobalData.shared.RemoveUser()
    }
    
    /// Returns the current user from the stored UUID, if any
    public static func GetCurrentUser() async -> User? {
        let keychain = Keychain(service: "online.tomk.The-Sleep-Synopsis")
        guard let _ = try? keychain.getString("uuid") else {
            return nil
        }
        
        do {
            let request = APIRequest(method: .get, path: "auth/currentuser")
            return try await APIClient.shared.perform(request, to: User.self)
        } catch {
            return nil
        }
    }
    
    /// Registers a new User and, if successful, returns the valid User object
    /// - Parameter dto: The details of the new user
    public static func RegisterUser(_ dto: NewUserDTO) async -> User? {
        do {
            let request = APIRequest(method: .post, path: "auth/register")
            return try await APIClient.shared.perform(request, to: User.self)
        } catch {
            return nil
        }
    }    
}
