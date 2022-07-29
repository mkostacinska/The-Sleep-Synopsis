//
//  SettingsText.swift
//  The Sleep Synopsis (iOS)
//
//  Created by Tom Knighton on 29/07/2022.
//

import SwiftUI

struct SettingsText: View {
    
    var prompt : String
    @Binding var text: String
    var isHidden : Bool = false
    var onSubmit : (String) -> () = {_ in}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if(!text.isEmpty){
                Text(prompt)
                    .font(.caption)
                    .foregroundColor(Color(.placeholderText))
                    .opacity(text.isEmpty ? 0 : 1)
                    .offset(y: text.isEmpty ? 20 : 0)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: text.isEmpty)
            }
            if(!isHidden){
                TextField(prompt, text: $text).onSubmit {
                    onSubmit(text)
                }
            }
            else{
                SecureField(prompt, text: $text).onSubmit {
                    onSubmit(text)
                }
            }
        }
        
    }
}
