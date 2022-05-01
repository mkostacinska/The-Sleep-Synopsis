//
//  SetBedtime.swift
//  The Sleep Synopsis
//
//  Created by Maja Kostacinska on 30/04/2022.
//

import SwiftUI

struct SetBedtime: View {
    @State var time: Date = Date()
    var name: String
    
    var body: some View {
        VStack {
            HStack {
                Text("What's your bedtime, \(name)?")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .padding(.top, 200)
            }
            HStack {
                DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
            }
            Spacer()
        }
    }
}

struct SetBedtime_Previews: PreviewProvider {
    static var previews: some View {
        SetBedtime(name: "Maja")
    }
}
