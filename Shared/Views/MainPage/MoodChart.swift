//
//  MoodChart.swift
//  The Sleep Synopsis (iOS)
//
//  Created by Tom Knighton on 31/07/2022.
//

import SwiftUI
import SwiftUICharts

struct MoodChart: View {
    
    let chartStyle = ChartStyle(backgroundColor: Color(hex: "#f2d5a3"), accentColor: Color(hex: "#dd9871"), gradientColor: GradientColor(start: Color(hex: "#dd9871"), end: Color(hex: "#dd9871")), lineDropGradientColor: GradientColor(start: .init(hex: "#e2a67d"), end: .init(hex: "e2a67d")), textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.clear)
    
    var body: some View {
        //cannot change the color of lineview?
        LineChartView(data: [0, 3, 4, 2], title: "Quality", legend: "How was your night?", style: chartStyle, rateValue: 0)
    }
    
    //add a way of calculating rate value
}

