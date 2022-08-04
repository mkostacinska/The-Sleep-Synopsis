//
//  UserAuth.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 02/08/2022.
//

import Foundation

public struct UserAuth: Codable {
    public var userEmail: String?
}

public struct UserLoginRequest: Codable {
    public var userAuthString: String?
    public var userPass: String?
}

public struct UserAuthenticationTokens: Codable {
    public var authenticationToken: String
    public var refreshToken: String
}

public struct UserRefreshToken: Codable {
    public var userUUID: String?
    public var refreshToken: String?
    public var tokenIssueDate: Date?
    public var tokenExpiryDate: Date?
    public var tokenClient: String?
    public var isDeleted: Bool?
}

public struct RefreshTokenDTO: Codable {
    public var userUUID: String
    public var refreshToken: String
}

public struct NewUserDTO: Codable {
    public var userName: String
    public var userFullName: String
    public var userPassword: String
    public var userEmail: String
}
