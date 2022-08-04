//
//  UserService.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 03/08/2022.
//

import Foundation

public struct UserService {
    
    /// Returns a list of all registered users
    public static func GetAllUsers() async -> [User]? {
        do {
            let request = APIRequest(method: .get, path: "users")
            return try await APIClient.shared.perform(request, to: [User].self)
        } catch {
            return nil
        }
    }
    
    /// Returns a user with the specified UUID, if they exist
    /// - Parameter userUUID: The UUID of the user
    public static func GetUser(_ userUUID: String) async -> User? {
        do {
            let request = APIRequest(method: .get, path: "users/\(userUUID)")
            return try await APIClient.shared.perform(request, to: User.self)
        } catch {
            return nil
        }
    }
    
    
    /// Searches all user's names based on a query string, can match exactly or be a partial match
    /// - Parameters:
    ///   - query: The string to query
    ///   - matchExactly: Whether or not to return only exact matches
    public static func Search(_ query: String, matchExactly: Bool = false) async -> [User]? {
        do {
            var request = APIRequest(method: .get, path: "users/search/\(query)")
            request.queryItems = [URLQueryItem(name: "matchExactly", value: matchExactly.description)]
            return try await APIClient.shared.perform(request, to: [User].self)
        } catch {
            return nil
        }
    }
    
}
