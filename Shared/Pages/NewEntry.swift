//
//  NewEntry.swift
//  The Sleep Synopsis (iOS)
//
//  Created by Tom Knighton on 31/07/2022.
//

import SwiftUI

struct NewEntry: View {
    @StateObject var viewModel = NewEntryViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Layer1").edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack(alignment: .leading){
                        Text("When did you go to bed?")
                            .font(.system(size: 25, weight: .regular, design: .default))
                        DatePicker("", selection: $viewModel.bedtime).datePickerStyle(.automatic)
                            .labelsHidden()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("When did you wake up?")
                            .font(.system(size: 25, weight: .regular, design: .default))
                        DatePicker("", selection: $viewModel.waketime).datePickerStyle(.automatic)
                            .labelsHidden()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 20)
                        
                        Text("How was your night?")
                            .font(.system(size: 25, weight: .regular, design: .default))
                        HStack{
                            ForEach(viewModel.moods, id: \.rawValue) { mood in
                                Button(action: {viewModel.selectMood(mood.rawValue)}){
                                    Spacer()
                                    Image(viewModel.selectedMood == mood.rawValue ? mood.selectedImage : mood.defaultImage)
                                        .resizable()
                                        .frame(maxWidth: 45, maxHeight: 45, alignment: .leading)
                                    Spacer()
                                        
                                }
                            }
                        }.padding(.bottom, 20)
                        
                        Text("Did you have any dreams?")
                            .font(.system(size: 25, weight: .regular, design: .default))
                        ForEach(viewModel.dreams, id: \.dreamUUID){ dream in
                            NavigationLink(destination: EmptyView()){
                                HStack{
                                    Image(systemName: "pencil")
                                    Text(dream.dreamTitle)
                                }
                            }
                        }
                        NavigationLink(destination: EmptyView()){
                            HStack{
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                Text("New dream")
                                    .font(.system(size: 17, weight: .semibold, design: .default))
                                    .foregroundColor(.black)
                            }.padding(16)
                            .background(Color(hex: "#f2d5a3"))
                                .opacity(0.5)
                                .cornerRadius(40)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        
                        Spacer()
                    }.padding(.horizontal, 16)
                }
                
            }.navigationTitle("Add a new entry:")
        }
    }
}

struct NewEntry_Previews: PreviewProvider {
    static var previews: some View {
        NewEntry()
    }
}
