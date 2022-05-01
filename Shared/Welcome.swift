//
//  Welcome.swift
//  The Sleep Synopsis
//
//  Created by Maja Kostacinska on 30/04/2022.
//

import SwiftUI

struct Welcome: View {
    @State var text: String = ""
    
    var body: some View {
        VStack (spacing: 2) {
            HStack {
            Text("Welcome, ")
                .font(.system(size: 70, weight: .bold, design: .rounded))
                .padding(.leading, 30)
            Spacer()
            }
            TextField("your name", text: $text)
                .font(.system(size: 70, weight: .bold, design: .rounded))
                .padding(.leading, 30)
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
