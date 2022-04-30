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
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
                
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            Text(current)
                .bold()
                .font(.system(size: 30))
            }
    }
}
