//
//  BedTimePage.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 09/08/2022.
//

import Foundation
import SwiftUI

struct BedTimePage: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: SetBedTimeViewModel = SetBedTimeViewModel()
    
    var body: some View {
        ZStack {
            Color.layer1.edgesIgnoringSafeArea(.all)
            
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        Spacer().frame(height: 16)
                        
                        Text("Set your bed time and when you want to wake up")
                            .font(.largeTitle.bold())
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Most adults need 8 hours of sleep to feel fully rested")
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        ForEach(self.viewModel.errors, id: \.self) { error in
                            Label(error, systemImage: "exclamationmark.circle")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.red)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        self.sleepClock(geo)
                        
                        Spacer()
                        
                        self.timeSheet()
                        
                        Button(action: { self.submit() }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .padding(8)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Spacer().frame(height: 16)
                    }
                    .frame(minHeight: geo.size.height)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    
    func submit() {
        if self.viewModel.saveTimes() {
            self.dismiss()
        }
    }
}

extension BedTimePage {
    
    @ViewBuilder
    func sleepClock(_ geo: GeometryProxy) -> some View {
        ZStack {
            ZStack {
                ForEach(1...120, id: \.self) { index in
                    Rectangle()
                        .fill(.black)
                        .frame(width: 2, height: index % 5 == 0 ? 15 : 5)
                        .offset(y: (geo.size.width - 90) / 2)
                        .rotationEffect(.degrees(Double(index) * 3))
                }
                
                let texts = [12,14,16,18,20,22,0,2,4,6,8,10]
                ForEach(texts.indices, id: \.self) { index in
                    Text("\(texts[index])")
                        .font(.caption.bold())
                        .foregroundColor(index % 3 == 0 ? .primary : .gray)
                        .rotationEffect(.degrees(Double(index) * -30))
                        .offset(y: (geo.size.width - 120) / 2)
                        .rotationEffect(.degrees(Double(index) * 30))
                }
            }
            
            Circle()
                .trim(from: 0, to: 360)
                .stroke(Color.layer1, lineWidth: 25)
                .brightness(-0.05)
                .shadow(radius: 3)
            
            let reverseRotation = (self.viewModel.startProgress > self.viewModel.endProgress) ? -Double((1 - viewModel.startProgress) * 360) : 0
            Circle()
                .trim(from: viewModel.startProgress > viewModel.endProgress ? 0 : viewModel.startProgress, to: viewModel.endProgress + (-reverseRotation / 360))
                .stroke(Color(hex: "#dd9871"), style: StrokeStyle(lineWidth: 25, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
                .rotationEffect(.degrees(reverseRotation))
                .shadow(radius: 3)
            
            Image(systemName: "moon.fill")
                .bedTimeImageModifier(angle: self.viewModel.startAngle, containerWidth: geo.size.width - 32)
                .onTapGesture { }
                .highPriorityGesture(DragGesture(minimumDistance: 0)
                    .onChanged({ viewModel.onDrag(value: $0, for: .bedtime) })
                )
                .rotationEffect(.degrees(-90))
            
            Image(systemName: "alarm")
                .bedTimeImageModifier(angle: self.viewModel.endAngle, containerWidth: geo.size.width - 32)
                .onTapGesture { }
                .highPriorityGesture(DragGesture(minimumDistance: 0)
                    .onChanged({ viewModel.onDrag(value: $0, for: .wakeup) })
                )
                .rotationEffect(.degrees(-90))
            
            
            VStack {
                Text("\(viewModel.timeDifference().0)hr")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color(hex: "#dd9871"))
                Text("\(viewModel.timeDifference().1)min")
                    .foregroundColor(.gray)
            }
            .scaleEffect(1.1)
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    func timeSheet() -> some View {
        HStack {
            Spacer()
            VStack(spacing: 8) {
                Label {
                    Text("Bedtime")
                        .foregroundColor(.primary)
                } icon: {
                    Image(systemName: "moon.fill")
                        .foregroundColor(.blue)
                }
                .font(.callout)
                
                Text(self.viewModel.getTotalTime(for: .bedtime).formatted(date: .omitted, time: .shortened))
                    .font(.title2.bold())
                
            }
            Spacer()
            VStack(spacing: 8) {
                Label {
                    Text("Wakeup")
                        .foregroundColor(.primary)
                } icon: {
                    Image(systemName: "alarm")
                        .foregroundColor(.blue)
                }
                .font(.callout)
                
                Text(self.viewModel.getTotalTime(for: .wakeup).formatted(date: .omitted, time: .shortened))
                    .font(.title2.bold())
                
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .background(Color.black)
                .opacity(0.06)
                .shadow(color: .red, radius: 5)
                .cornerRadius(15)
        )
        .onChange(of: self.viewModel.timeDifference().1) { newValue in
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred(intensity: 0.5)
        }
    }
}
