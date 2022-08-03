//
//  The_Sleep_SynopsisApp.swift
//  Shared
//
//  Created by Maja Kostacinska on 29/04/2022.
//

import SwiftUI

@main
struct The_Sleep_SynopsisApp: App {
    
    @StateObject private var global: GlobalData = GlobalData.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        if let user = await AuthService.GetCurrentUser() {
                            print("current user: \(user.userName)")
                            self.global.SetCurrentUser(to: user)
                        }
                        
                    }
                }
        }
    }
}
