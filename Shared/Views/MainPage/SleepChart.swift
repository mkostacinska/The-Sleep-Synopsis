//
//  SleepChart.swift
//  The Sleep Synopsis (iOS)
//
//  Created by Tom Knighton on 30/07/2022.
//

import SwiftUI
import SwiftUICharts

struct SleepChart: View {
    let chartStyle = ChartStyle(backgroundColor: Color(hex: "#f2d5a3"), accentColor: Color(hex: "#dd9871"), secondGradientColor: Color(hex: "#dd9871"), textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.clear)
    
    @State var sleepEntries: [SleepEntry] = []
    
    var body: some View {
        BarChartView(data: ChartData(values: [("MON", 8), ("TUES", 6),
                                              ("WED", 4), ("THURS", 7),
                                              ("FRI", 10), ("SAT", 2),
                                              ("SUN", 6)]), title: "Your sleep synopsis:", legend: "weekly", style: chartStyle, form: ChartForm.medium)
    }
    
    func getValues() -> [(String, Int)] {
        //TODO: Somehow get all days in week, sort sleeps into days
        return []
    }
}

