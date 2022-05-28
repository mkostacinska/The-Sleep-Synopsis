//
//  TopCard.swift
//  The Sleep Synopsis
//
//  Created by Maja Kostacinska on 29/04/2022.
//

import SwiftUI

struct TopCard: View {
    @State var progressValue: Float = 0.0
    
    // @AppStorage reads from UserDefaults.standard (changing self.name here will update UserDefaults too)
    @AppStorage("username") private var name: String = ""
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1.0)) { _ in
            VStack(spacing: 5) {
                HStack {
                    Text(getHeader())
                        .font(.system(size: 40, weight: .bold, design: .rounded))
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
                    Text(getCountdown())
                        .font(.system(size: 20, design: .rounded))
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.gray)
                .opacity(0.8)
                .cornerRadius(40)
                .padding(10)
                Spacer()
            }
        }
        
    }
    
    func getProgress() -> Float {
        let b = TheSleepSynopsis.getBedtime()
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
        let b = TheSleepSynopsis.getBedtime()
        let bedTime = b.0*60 + b.1
        let current = Calendar.current.component(.hour, from: Date())*60 + Calendar.current.component(.minute, from: Date())
        
        let remaining = bedTime - current
        let remainingH = Int(remaining/60)
        let remainingM = remaining - remainingH*60
        
        return (remainingH, remainingM)
    }
    
    func untilWake() -> (Int, Int) {
        let w = TheSleepSynopsis.getWaketime()
        let wakeTime = w.0*60 + w.1
        let current = Calendar.current.component(.hour, from: Date())*60 + Calendar.current.component(.minute, from: Date())
        
        let remaining = wakeTime - current
        let remainingH = Int(remaining/60)
        let remainingM = remaining - remainingH*60
        
        return (remainingH, remainingM)
    }
    
    func getHeader() -> String {
        // TODO:
        // 1. what if bedtime set after midnight? time to wake will remain positive
        let currentH = Calendar.current.component(.hour, from: Date())
        let currentM = Calendar.current.component(.minute, from: Date())
        let bedTime = TheSleepSynopsis.getBedtime()
        let wakeTime = TheSleepSynopsis.getWaketime()
                
        if ((currentH < wakeTime.0 || (currentH == wakeTime.0 && currentM < wakeTime.1)) ||
            (currentH > bedTime.0 || (currentH == bedTime.0 && currentM > bedTime.1))) {
            return "Trouble sleeping,\n\(self.name)?"
        }
        
        if currentH <= 4 {
            return "Early morning,\n\(self.name)?"
        }
        else if currentH <= 12 {
            return "Good morning,\n\(self.name)!"
        }
        else if currentH <= 18 {
            return "Good afternoon,\n\(self.name)!"
        }
        else {
            return "Good evening,\n\(self.name)!"
        }
    }
    
    func getCountdown() -> String {
        //TODO:
        // 1. what if bedtime set after midnight? timeuntilwake is going to be positive
        // 2. calculating the time past/before
        
        let timeUntilBed = untilBed()
        let timeUntilWake = untilWake()
        
        if (timeUntilWake.0>0 || timeUntilWake.1>0) || (timeUntilBed.0<0 || timeUntilBed.1<0){
            if timeUntilBed.1 == 0 {
                return "\(-timeUntilBed.0)h past bedtime."
            }
            return "\(-timeUntilBed.0)h \(-timeUntilBed.1)min past bedtime."
        }
        

        if timeUntilBed.0==0 && timeUntilBed.1<=30 {
            return "Start winding down"
        }
        else {
            if timeUntilBed.1 == 0 {
                return "\(timeUntilBed.0)h until bedtime."
            }
            return "\(timeUntilBed.0)h \(timeUntilBed.1)min until bedtime."
        }
    }
}

struct TopCard_Previews: PreviewProvider {
    static var previews: some View {
        TopCard()
            .previewLayout(.device)
    }
}
