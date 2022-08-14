//
//  TopCard.swift
//  The Sleep Synopsis
//
//  Created by Maja Kostacinska on 29/04/2022.
//

import SwiftUI

struct TopCard: View {
    @State var progressValue: Float = 0.0
    @StateObject private var globalData: GlobalData = GlobalData.shared
    
    // @AppStorage reads from UserDefaults.standard (changing self.name here will update UserDefaults too)
    @AppStorage("username") private var name: String = ""
    @AppStorage("bedtime") var bedTime: Date?
    @AppStorage("waketime") var wakeTime: Date?
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1.0)) { _ in
            VStack(spacing: 5) {
                HStack {
                    Text(getHeader())
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .padding(.leading, 10)
                        .padding(.top, 5)
                    Spacer()
                }
                HStack {
                    ZStack {
                        VStack{
                            DayProgress(progress: getProgress(), current: currentTime())
                                .frame(width: 80, height: 80)
                                .padding(15)
                        }
                    }
                    HStack{
                        Text(getCountdown())
                            .font(.system(size: 24, design: .default))
                            .bold()
                            .frame(maxWidth: .infinity)
                    }.padding(.leading, 50)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Image("TopCardBackground").resizable())
                .opacity(0.8)
                .cornerRadius(40)
                .padding(10)
            }
        }
        
    }
    
    func getProgress() -> Float {
        guard let bedTime = bedTime else {
            return 0
        }
        let b = (Calendar.current.component(.hour, from: bedTime), Calendar.current.component(.minute, from: bedTime))
        let total = Float(b.0*60 + b.1)
        let current = Float(Calendar.current.component(.hour, from: Date())*60 + Calendar.current.component(.minute, from: Date()))
        
        return current/total
    }
    
    func currentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: Date())
    }
    
    // This will need to be modified when we add manual bedtime setting
    func untilBed() -> (Int, Int) {
        guard let savedBedTime = bedTime else {
            return (0, 0)
        }
        let b = (Calendar.current.component(.hour, from: savedBedTime), Calendar.current.component(.minute, from: savedBedTime))
        let bedTime = b.0*60 + b.1
        let current = Calendar.current.component(.hour, from: Date())*60 + Calendar.current.component(.minute, from: Date())
        
        let remaining = bedTime - current
        let remainingH = Int(remaining/60)
        let remainingM = remaining - remainingH*60
        
        return (remainingH, remainingM)
    }
    
    func getHeader() -> String {
        let currentH = Calendar.current.component(.hour, from: Date())
        let currentM = Calendar.current.component(.minute, from: Date())
        guard let savedBedTime = bedTime else {
            return ""
        }
        let bedTime = (Calendar.current.component(.hour, from: savedBedTime), Calendar.current.component(.minute, from: savedBedTime))
        
        if (currentH > bedTime.0) || (currentH == bedTime.0 && currentM > bedTime.1) {
            return "Trouble sleeping,\n\(globalData.CurrentUser?.userName ?? "")?"
        }
        
        if currentH <= 4 {
            return ""
        }
        else if currentH <= 12 {
            return "Good morning,\n\(globalData.CurrentUser?.userName ?? "")!"
        }
        else if currentH <= 18 {
            return "Good afternoon,\n\(globalData.CurrentUser?.userName ?? "")!"
        }
        else {
            return "Good evening,\n\(globalData.CurrentUser?.userName ?? "")!"
        }
    }
    
    func getCountdown() -> String {
        let timeUntil = untilBed()
        if timeUntil.0<0 || timeUntil.1 < 0 {
            if timeUntil.1 == 0 {
                return "\(-timeUntil.0)h past bedtime."
            }
            return "\(-timeUntil.0)h \(-timeUntil.1)min past bedtime."
        }
        else if timeUntil.0==0 && timeUntil.1<=30 {
            return "Start winding down"
        }
        else {
            if timeUntil.1 == 0 {
                return "\(timeUntil.0)h until bedtime."
            }
            return "\(timeUntil.0)h \(timeUntil.1)min until bedtime."
        }
    }
}

struct TopCard_Previews: PreviewProvider {
    static var previews: some View {
        TopCard()
            .previewLayout(.device)
    }
}
