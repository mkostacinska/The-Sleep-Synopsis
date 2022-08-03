//
//  User.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 02/08/2022.
//

import Foundation

public struct User: Codable, Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        lhs.userUUID == rhs.userUUID
    }
    
    public var userUUID: String?
    public var userName: String?
    public var userFullName: String?
    public var userProfilePictureUrl: String?
    public var userRole: UserRole?
    public var deletedAt: Date?
    public var authTokens: UserAuthenticationTokens?
    public var sleepEntries: [SleepEntry]?
//    public var following: [Friendship]?
//    public var followers: [Friendship]?
    public var userAuth: UserAuth?
}

public enum UserRole: String, Codable {
    case user = "user"
    case admin = "admin"
}
