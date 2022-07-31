//
//  MainPage.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI

struct MainPage: View {
    
    @State private var showScreen: Bool = true
    
    var body: some View {
        ZStack{
            Color("Layer1").edgesIgnoringSafeArea(.all)
            VStack {
                TopCard()
                HStack{
                    SleepChart()
                    MoodChart()
                }
                VStack{
                    HStack{
                        Image(systemName: "plus")
                        Text("Add a new sleep entry")
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(16)
                    .background(Color(hex: "#dd9871"))
                    .cornerRadius(40)
                    .padding(16)
                    .onTapGesture {
                        self.showScreen.toggle()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .sheet(isPresented: $showScreen) {
            NewEntry()
        }
    }
}
