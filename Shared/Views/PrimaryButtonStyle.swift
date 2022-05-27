//
//  PrimaryButtonStyle.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .padding(.horizontal, 32)
            .background(configuration.isPressed ? Color(hex: "f06553").darker(by: 7) : Color(hex: "f06553"))
            .cornerRadius(15)
            .shadow(radius: 3)
    }
    
}
