//
//  ContentView.swift
//  Shared
//
//  Created by Maja Kostacinska on 29/04/2022.
//

import SwiftUI
import Introspect
import SwiftUICharts

struct ContentView: View {
    @State private var selection = 2
    
    @State private var hasInit: Bool = false
    
    var body: some View {
        ZStack {
            if UserDefaults.standard.value(forKey: "username") == nil { // IF we havent setup yet
                WelcomePage()
            } else { // If we have, show main page
                TabView(selection: $selection) {
                    ProfileSettings().tag(1)
                    MainPage().tag(2)
                    VStack{
                        Text("I dont remember what i wanted to put here but i want three otherwise my brain will explode (threat)")
                    }.tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
            }
        }
    }
    
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
