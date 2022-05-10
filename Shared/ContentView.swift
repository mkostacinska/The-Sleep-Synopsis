//
//  ContentView.swift
//  Shared
//
//  Created by Maja Kostacinska on 29/04/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if UserDefaults.standard.value(forKey: "username") == nil { // IF we havent setup yet
            WelcomePage()
        } else { // If we have, show main page
            MainPage()
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
