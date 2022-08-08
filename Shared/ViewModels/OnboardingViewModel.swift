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
public class OnboardingViewModel: ObservableObject {
    
    @Published var name: String = "" // Published vars re-draw views like state vars do
    @Published var email: String = ""
    @Published var pass: String = ""
    @Published var uname: String = ""
    @Published var bedTime: Date = Date()
    @Published var wakeTime: Date = Date()
    @Published var currentSection: section = .auth
    @Published var isAlert: Bool = false
    @Published var alertDetails : [String] = ["",""]
    @Published var showMainPage : Bool = false
    
    enum section {
        case auth, name, bedtime, timeToSleep
    }
    
    func save() async {
        if let user = await AuthService.RegisterUser(NewUserDTO(userName: self.uname, userFullName: self.name, userPassword: self.pass, userEmail: self.pass)) {
            let keychain = Keychain(service: "online.tomk.The-Sleep-Synopsis")
            try? keychain.set(user.userUUID ?? "", key: "uuid")
            try? keychain.set(user.authTokens?.refreshToken ?? "", key: "refresh")
            try? keychain.set(user.authTokens?.authenticationToken ?? "", key: "jwt")
            GlobalData.shared.SetCurrentUser(to: user)
            self.showMainPage = true
        }
        else {
            self.alertDetails = ["Something went wrong", "Please reenter your details"]
            self.isAlert = true
        }
        
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
