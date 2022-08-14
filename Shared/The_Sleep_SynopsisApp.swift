//
//  The_Sleep_SynopsisApp.swift
//  Shared
//
//  Created by Maja Kostacinska on 29/04/2022.
//

import SwiftUI

@main
struct The_Sleep_SynopsisApp: App {
    
    @AppStorage("isFirstInstall") private var isFirstInstall: Bool = true
    @StateObject private var global: GlobalData = GlobalData.shared
    @State private var isLoading: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isLoading {
                    // Splash screen
                    Color.layer1.edgesIgnoringSafeArea(.all)
                } else {
                    if global.CurrentUser == nil || isFirstInstall {
                        WelcomePage()
                    } else {
                        ContentView()
                    }
                }
            }
            .task {
                if let user = await AuthService.GetCurrentUser() {
                    self.global.SetCurrentUser(to: user)
                    self.isLoading = false
                } else {
                    self.isLoading = false
                }
            }
            
        }
    }
}
