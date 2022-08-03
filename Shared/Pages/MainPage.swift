//
//  MainPage.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI

struct MainPage: View {
    
    @State private var showScreen: Bool = false
    @StateObject private var globalData: GlobalData = GlobalData.shared
    @State private var sleepData: [SleepEntry]? = nil
    
    var body: some View {
        ZStack{
            Color("Layer1").edgesIgnoringSafeArea(.all)
            VStack {
                TopCard()
                Text(self.globalData.CurrentUser?.userName ?? "No user :(") //TODO: Delete
                HStack{
                    SleepChart()
                    MoodChart(sleepMoods: self.$sleepData)
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
        .onAppear {
            self.getSleepData()
        }
        .onChange(of: self.globalData.CurrentUser, perform: { newValue in
            Task {
                self.sleepData = await SleepService.SleepEntries(for: newValue?.userUUID ?? "")!
            }
        })
        .sheet(isPresented: $showScreen) {
            NewEntry()
        }
    }
    
    func getSleepData() {
        Task {
            if let _ = globalData.CurrentUser,
               let sleeps = await SleepService.MySleepEntries() {
                self.sleepData = sleeps
            }
        }
    }
}
