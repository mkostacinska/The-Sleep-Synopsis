//
//  Date+TSS.swift
//  The Sleep Synopsis
//
//  Created by Maja Kostacinska on 29/04/2022.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
