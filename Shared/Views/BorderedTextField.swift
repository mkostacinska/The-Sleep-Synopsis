//
//  BorderedTextField.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI

struct BorderedTextField: View {
    
    var placeHolder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        textView
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
            )
    }
    
    @ViewBuilder
    var textView: some View {
        if isSecure {
            SecureField(placeHolder, text: $text)
        } else {
            TextField(placeHolder, text: $text)
        }
    }
}

struct BorderedDatePicker: View {
    
    @Binding var time: Date
    
    var body: some View {
        DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
            )
    }
}
