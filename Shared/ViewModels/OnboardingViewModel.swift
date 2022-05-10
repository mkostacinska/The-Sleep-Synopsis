//
//  OnboardingViewModel.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI

public class OnboardingViewModel: ObservableObject {
    
    @Published var name: String = "" // Published vars re-draw views like state vars do
    @Published var bedTime: Date = Date()
    @Published var wakeTime: Date = Date()
    @Published var currentSection: section = .name
    
    enum section {
        case name, bedtime, timeToSleep
    }
    
    func save() { // Local storage :)
        UserDefaults.standard.set(self.name, forKey: "username")
        UserDefaults.standard.set(self.bedTime, forKey: "bedtime")
        UserDefaults.standard.set(self.wakeTime, forKey: "waketime")
    }
    
    func welcomeText() -> String {
        return self.name.isEmpty ? "Welcome" : "Welcome, \(self.name)"
    }
    
    func goTo(section: section) {
        withAnimation(.easeInOut) { // withAnimation makes sure the currentSection triggers any relevant animations in view
            self.currentSection = section
        }
    }
}
