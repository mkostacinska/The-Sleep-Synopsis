//
//  WelcomePage.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI

struct WelcomePage: View {
    
    @State private var showLoginPage: Bool = false
    @State private var showSignupPage: Bool = false
        
    var body: some View {
        ZStack {
            Color.layer1.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer().frame(height: 16)
                Text("The Sleep Synopsis")
                    .bold()
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                Spacer().frame(height: 8)
                
                LottieView(name: "lottie_sleep", loopMode: .loop)
                
                Text("Let's Get Started")
                    .bold()
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Button(action: { self.showLoginPage.toggle() }) {
                    Text("Login")
                        .padding(.all, 8)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button(action: { self.showSignupPage.toggle() }) {
                    Text("Signup")
                        .padding(.all, 8)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Button(action: {}) {
                    Text("Reset your password")
                        .frame(maxWidth: .infinity)
                }
                
                Spacer().frame(height: 16)
            }
            .padding(.horizontal)
            .sheet(isPresented: $showLoginPage) {
                LoginPage()
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $showSignupPage) {
                SignupPage()
                    .interactiveDismissDisabled()
            }
        }
    }
    
}


