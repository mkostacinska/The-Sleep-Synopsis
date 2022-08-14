//
//  Login.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 08/08/2022.
//

import Foundation
import SwiftUI

struct LoginPage: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color.layer1.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer().frame(height: 16)
                HStack {
                    Text("The Sleep Synopsis")
                        .bold()
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    
                    Button(action: { withAnimation { self.dismiss() } }) {
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
                
                
                Spacer()
                
                Group {
                    Text("Login:")
                        .bold()
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    if !self.viewModel.errors.isEmpty {
                        Spacer().frame(height: 8)
                        ForEach(self.viewModel.errors, id: \.self) { error in
                            Label(error, systemImage: "exclamationmark.circle")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.red)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    
                    
                    BorderedTextField(placeHolder: "Email/Username", text: $viewModel.authString)
                    BorderedTextField(placeHolder: "Password", text: $viewModel.password, isSecure: true)
                }
                
                Spacer()
                
                Button(action: { self.viewModel.login() }) {
                    Text("Login")
                        .padding(.all, 8)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                

                Spacer().frame(height: 16)
            }
            .padding(.horizontal)
            .fullScreenCover(isPresented: $viewModel.loggedIn) {
                ContentView()
            }
        }
    }
}
