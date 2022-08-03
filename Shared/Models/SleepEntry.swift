//
//  SleepEntry.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 02/08/2022.
//

import Foundation

public struct SleepEntry: Codable {
    public var sleepUUID: String?
    public var userUUID: String?
    public var sleepStart: Date?
    public var sleepEnd: Date?
    public var sleepMood: Int?
    public var dreams: [Dream]?
    
    public init(sleepStart: Date, sleepEnd: Date, sleepMood: Int) {
        self.sleepStart = sleepStart
        self.sleepEnd = sleepEnd
        self.sleepMood = sleepMood
        self.dreams = []
    }
    
    public init(sleepStart: Date, sleepEnd: Date, sleepMood: Int, dreams: [Dream]) {
        self.init(sleepStart: sleepStart, sleepEnd: sleepEnd, sleepMood: sleepMood)
        self.dreams = dreams
    }
}

