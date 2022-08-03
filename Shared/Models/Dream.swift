//
//  Dream.swift
//  The Sleep Synopsis (iOS)
//
//  Created by Tom Knighton on 31/07/2022.
//

import Foundation

public struct Dream: Codable {
    var dreamUUID : String
    var sleepEntryUUID : String
    var dreamTitle : String
    var dreamText : String
    var createdAt: Date
    var modifiedAt: Date?
    
    init(title: String, text: String) {
        self.dreamUUID = ""
        self.sleepEntryUUID = ""
        self.dreamTitle = title
        self.dreamText = text
        self.createdAt = Date()
        self.modifiedAt = nil
    }
}

public struct EditDreamDTO: Codable {
    var dreamUUID: String
    var dreamTitle: String
    var dreamText: String
}
