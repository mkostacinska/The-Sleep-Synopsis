//
//  AuthViewModels.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 08/08/2022.
//

import Foundation
import SwiftUI

@MainActor
public class LoginViewModel: ObservableObject {
    
    @Published var authString: String = ""
    @Published var password: String = ""
    
    @Published var loggedIn: Bool = false
    
    @Published var errors: [String] = []
    
    func login() {
        
        self.errors.removeAll()
        
        guard self.validateLogins() else {
            return
        }
        
        Task {
            if let _ = await AuthService.Login(userAuthenticator: authString, password: password) {
                self.loggedIn = true
            } else {
                self.errors.append("Username/Email or password incorrect")
            }
        }
    }
    
    func validateLogins() -> Bool {
        
        let auth = self.authString.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = self.authString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if auth.isEmpty || pass.isEmpty {
            self.errors.append("Please enter a valid email/username and password")
            return false
        }
        
        return true
    }
}

@MainActor
public class SignupViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = "" {
        didSet {
            if !password.allSatisfy({ allowedPassCharacters.contains($0)}) && oldValue.allSatisfy({ allowedPassCharacters.contains($0)}) {
                password = oldValue
            }
        }
    }
    @Published var passwordConf: String = ""
    @Published var username: String = "" {
        didSet {
            if username.count > 16 && oldValue.count <= 16 {
                username = oldValue
            }
            if !username.allSatisfy({ allowedPassCharacters.contains($0)}) && oldValue.allSatisfy({ allowedPassCharacters.contains($0)}) {
                username = oldValue
            }
        }
    }
    @Published var fullName: String = ""
    
    @Published var errors: [String] = []
    
    @Published var currentSection: SignupSection = .names
    
    @Published var isLoading: Bool = false
    
    private var allowedPassCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!~-_?#.@%+/\\^0123456789"
    
    enum SignupSection {
        case names, auth
    }
    
    func moveTo(_ section: SignupSection) {
        withAnimation {
            self.errors.removeAll()
            self.currentSection = section
        }
    }
    
    func validateNames() async -> Bool {
        
        self.errors.removeAll()
        let name = self.fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        let uName = self.username.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if name.isEmpty || uName.isEmpty {
            self.errors.append("Please enter your name and a username")
            return false
        }
        
        if uName.count < 5 {
            self.errors.append("Username must be more than 4 characters")
            return false
        }
        
        self.isLoading = true
        if await AuthService.IsUsernameFree(uName) == false {
            self.errors.append("Chosen username is not available")
            self.isLoading = false
            return false
        }
        self.isLoading = false
        
        return true
    }
    
    func validateAuth() async -> Bool {
        
        self.errors.removeAll()
        let email = self.email.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = self.password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passConf = self.passwordConf.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty || pass.isEmpty {
            self.errors.append("Please enter a valid email address and password")
            return false
        }
        
        if passConf.isEmpty || pass != passConf {
            self.errors.append("Passwords do not match")
            return false
        }
        
        if !emailPred.evaluate(with: email) {
            self.errors.append("Please enter a valid email address in the format xxx@xxx.xx")
            return false
        }
        
        if pass.count < 6 {
            self.errors.append("Password must be more than 6 characters")
            return false
        }
        
        self.isLoading = true
        if await AuthService.IsEmailFree(email) == false {
            self.errors.append("Your email address is already registered with an account")
            self.isLoading = false
            return false
        }
        self.isLoading = false
        
        return true
    }
}
