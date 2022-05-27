//
//  DayProgress.swift
//  The Sleep Synopsis
//
//  Created by Maja Kostacinska on 30/04/2022.
//

import SwiftUI

struct DayProgress: View {
    var progress: Float
    var current: String
    
    @State var gradient: AngularGradient = AngularGradient(gradient: Gradient(colors: [Color.purple, Color.orange, Color.red]), center: .center, startAngle: .degrees(270), endAngle: .degrees(0))
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.3)
                .foregroundColor(Color.purple)
                
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .overlay(
                    Circle()
                        .trim(from: 0, to: CGFloat(min(self.progress, 1)))
                        .stroke(gradient, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    
                )
                .rotationEffect(Angle(degrees: 270))
                
            Text(current)
                .bold()
                .font(.system(size: 20, design: .rounded))
            }
    }
}
