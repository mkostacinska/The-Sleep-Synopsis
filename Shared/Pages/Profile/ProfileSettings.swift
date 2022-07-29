//
//  ProfileSettings.swift
//  The Sleep Synopsis (iOS)
//
//  Created by Maja Kostacinska and Tom Knighton on 29/07/2022.
//

import SwiftUI
import Introspect

struct ProfileSettings: View {
    @AppStorage("username") var username : String = ""
    @AppStorage("password") var password : String = ""
    @StateObject var viewModel : SettingsModel = SettingsModel()
    
    var body: some View {
        ZStack{ Color("Layer1").edgesIgnoringSafeArea(.all)
            VStack(spacing: 0){
                HStack{
                    Image("profileSynopsis")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                        .padding(.leading, 10)
                    Spacer().frame(width: 15)
                    VStack(alignment: .leading){
                        Text(username)
                            .font(.system(size: 40, weight: .bold, design: .rounded)).multilineTextAlignment(.leading)
                        Text("(some more information or something tom smells)").multilineTextAlignment(.leading).font(.system(size: 15, weight: .thin, design: .rounded)).foregroundColor(.init(hex: "#D4D4D4"))
                    }
                }.frame(maxHeight: 100).padding()
                List{
                    Section("Personal Info"){
                        SettingsText(prompt: "username", text: $viewModel.name)
                    }
                    Section("App Settings"){
                        DatePicker("bedtime", selection: $viewModel.bedtime, displayedComponents: .hourAndMinute)
                        DatePicker("waketime", selection: $viewModel.waketime, displayedComponents: .hourAndMinute)
                    }
                }
                .listStyle(.insetGrouped)
                .introspectTableView { tableView in
                    tableView.backgroundColor = .clear
                }
                
                if(viewModel.showButton){
                    Button(action: { viewModel.save() }) {
                        Text("save changes")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
            }.onAppear{
                viewModel.setup()
            }
        }
    }
}

struct ProfileSettings_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettings()
    }
}
