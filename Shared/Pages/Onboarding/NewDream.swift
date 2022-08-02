//
//  NewDream.swift
//  The Sleep Synopsis
//
//  Created by Maja Kostacinska on 01/08/2022.
//

import SwiftUI

struct NewDream: View {
    @Binding var dream : String
    
    var body: some View {
        ZStack{
            Image("Layer1")
                .edgesIgnoringSafeArea(.all)
        }
    }
}

