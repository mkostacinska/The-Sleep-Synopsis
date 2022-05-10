//
//  WelcomePage.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 10/05/2022.
//

import Foundation
import SwiftUI

struct WelcomePage: View {
    
    // ObservedObject contains Published variables that act like State variables,
    // Just a nice way to move code out of this view :)
    @ObservedObject private var viewModel: OnboardingViewModel = OnboardingViewModel()
    
    // Animations need 'change' values, so we track here whether or not to show the button (trigger the animation to show button)
    @State private var showButton: Bool = false
    
    @State private var showMainPage: Bool = false
    
    
    var body: some View {
        ZStack {
            // I added a custom colour called layer1, i added it in Assets.xcassets and then in the Color+TSS extension file, it becomes the background of the view as its the back in ZStack, and i set it to ignore all edges (fill entire view)
            Color.layer1.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(self.viewModel.welcomeText())
                    .font(.system(size: 35, weight: .black, design: .rounded))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("We just need a few details to set you up :)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
                
                Spacer().frame(height: 64)
                
                // Animations in swift only work when showing/hiding something, with if statemens or switches, this way everything animates + we can easily see what content to display for this section
                // viewModel keeps track of what step we're on (could add back button as well?)
                switch self.viewModel.currentSection {
                case .name:
                    BorderedTextField(placeHolder: "What should we call you?", text: self.$viewModel.name) // Custom view I made with a border around a text field
                        .transition(.move(edge: .leading)) // Where the animation comes from
                    // Animations need transitions + if statement to be able to animate
                    
                    // Again, if statement enables animation when showButton is triggered
                    if self.showButton {
                        Button(action: { self.viewModel.goTo(section: .bedtime) }) {
                            Text("Next")
                        }
                        .buttonStyle(PrimaryButtonStyle()) // Custom button style i made in Views folder
                        .transition(.move(edge: .bottom))
                    }
                    
                case .bedtime:
                    Text(self.getBedTimeHeader())
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .transition(.move(edge: .leading))

                    BorderedDatePicker(time: self.$viewModel.bedTime) // Custom date picker I made in Views folder
                        .transition(.move(edge: .leading))
                    if self.showButton {
                        Button(action: { self.viewModel.goTo(section: .timeToSleep)}) {
                            Text("Confirm :)")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .transition(.move(edge: .bottom))
                    }
                case .timeToSleep:
                    
                    Group {
                        Text("And when would you like to wake up?")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .transition(.move(edge: .leading))
                            .multilineTextAlignment(.center)
                        Text("Most adults need around 6-9 hours!")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .transition(.move(edge: .leading))
                            .multilineTextAlignment(.center) // This one just says when the text spills over one line, make it all centered
                    }
                    
                    BorderedDatePicker(time: self.$viewModel.wakeTime)
                        .transition(.move(edge: .leading))
                    
                    if self.showButton {
                        Button(action: { self.viewModel.save(); self.showMainPage = true }) {
                            Text("Finish! :)")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .transition(.move(edge: .bottom))
                    }
                }
                
                
                
                Spacer()
            }
            .padding()
        }
        .onChange(of: self.viewModel.name) { newValue in // just listens for changes in view model values
            if !self.showButton && !newValue.isEmpty { // If we should show button
                withAnimation(.spring()) { // set showButton to true with spring animation :)
                    self.showButton.toggle()
                }
            } else if self.showButton && newValue.isEmpty {
                withAnimation(.spring()) {
                    self.showButton.toggle()
                }
            }
        }
        .onChange(of: self.viewModel.bedTime, perform: { newValue in
            if !self.showButton {
                withAnimation(.spring()) {
                    self.showButton.toggle()
                }
            }
        })
        .onChange(of: self.viewModel.wakeTime, perform: { newValue in
            if !self.showButton {
                withAnimation(.spring()) {
                    self.showButton.toggle()
                }
            }
        })
        .onChange(of: self.viewModel.currentSection) { newValue in
            self.showButton = false
        }
        
        .fullScreenCover(isPresented: self.$showMainPage, onDismiss: {}) {
            MainPage() // fullScreenCover says, if showMainPage is true, cover this page with MainPage()
        }
    }
    
    
    func getBedTimeHeader() -> String {
        return "Okay " + (self.viewModel.name.split(separator: " ").first ?? "") + ", when do you want to go to sleep?"
    }
}

struct WelcomePagePreviews: PreviewProvider {
    
    static var previews: some View {
        WelcomePage()
            .preferredColorScheme(.dark)
    }
}


