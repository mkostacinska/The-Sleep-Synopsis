//
//  OnboardingViewModel.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI
import KeychainAccess

@MainActor
public class SetBedTimeViewModel: ObservableObject {
    @Published var startAngle: Double = 0
    @Published var endAngle: Double = 120
    
    @Published var startProgress: CGFloat = 0
    @Published var endProgress: CGFloat = 120/360
    
    @Published var errors: [String] = []
    
    private let dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    enum AngleType {
        case bedtime, wakeup
    }
    
    func onDrag(value: DragGesture.Value, for angleType: AngleType) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - 15, vector.dx - 15) // Removes button radius
        
        var angle = radians * 180 / Double.pi
        if angle < 0 {
            angle = 360 + angle
        }
        
        let progress = angle / 360
        
        if angleType == .bedtime {
            self.startAngle = angle
            self.startProgress = progress
            
            
        } else {
            self.endAngle = angle
            self.endProgress = progress
        }
    }
    
    func getTotalTime(for angleType: AngleType) -> Date {
        
        let progress = (angleType == .bedtime ? self.startAngle : self.endAngle) / 15
        let hour = Int(progress)
        let remainder = (progress.truncatingRemainder(dividingBy: 1) * 12).rounded()
        
        var minute = remainder * 5
        minute = (minute > 55 ? 55 : minute)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month,.day,.year], from: Date())
        let rawDay = components.day ?? 0
        var day: Int = 0
        
        if angleType == .wakeup {
            day = rawDay + 1
        } else {
            day = (self.startAngle > self.endAngle) ? rawDay : rawDay + 1
        }
        
        if let date = dateFormatter.date(from: "\(components.year ?? 0)-\(components.month ?? 0)-\(day) \(hour == 24 ? 0 : hour):\(Int(minute)):00") {
            return date
        }
        
        return Date()
    }
    
    func timeDifference() -> (Int, Int) {
        let calendar = Calendar.current
        
        let result = calendar.dateComponents([.hour, .minute], from: getTotalTime(for: .bedtime), to: getTotalTime(for: .wakeup))
        
        return (result.hour ?? 0, result.minute ?? 0)
    }
    
    func saveTimes() -> Bool {
        guard timeDifference().0 >= 1 else {
            self.errors.append("Your bed time must be at least 1 hour before you wake up. We recommend 8 hours of sleep.")
            return false
        }
        
        UserDefaults.standard.set(self.getTotalTime(for: .bedtime).timeIntervalSinceReferenceDate.description, forKey: "bedtime")
        UserDefaults.standard.set(self.getTotalTime(for: .wakeup).timeIntervalSinceReferenceDate.description, forKey: "waketime")
        return true
    }
}
