//
//  View+TSS.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI

private struct BedTimeImageModifier: ViewModifier {
    
    var angle: Double
    var containerWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(.blue)
            .frame(width: 30, height: 30)
            .rotationEffect(.degrees(90))
            .rotationEffect(.degrees(-angle))
            .background(.white, in: Circle())
            .offset(x: containerWidth / 2)
            .rotationEffect(.degrees(angle))
    }
}

extension View {
    func hideKeyboardWhenTappedAround() -> some View {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func bedTimeImageModifier(angle: Double, containerWidth: CGFloat) -> some View {
        modifier(BedTimeImageModifier(angle: angle, containerWidth: containerWidth))
    }
    
}
