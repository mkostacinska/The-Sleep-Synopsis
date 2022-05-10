//
//  MainPage.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI

struct MainPage: View {
    
    var body: some View {
        ZStack {
            Color.layer1.edgesIgnoringSafeArea(.all)
            VStack {
                TopCard()
            }
        }
       
    }
}
