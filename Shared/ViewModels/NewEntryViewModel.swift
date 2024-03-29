//
//  NewEntryViewModel.swift
//  The Sleep Synopsis (iOS)
//
//  Created by MAJA on 31/07/2022.
//

import Foundation

public class NewEntryViewModel : ObservableObject {
    @Published var bedtime : Date = Date()
    @Published var waketime : Date = Date()
    @Published var selectedMood : Int?
    @Published var dreams : [Dream] = []
    var moods : [SleepMood]
    
    init() {
        moods = [SleepMood(rawValue: 1, name: "Awful", defaultImage: "AwfulUnselect", selectedImage: ""),
                 SleepMood(rawValue: 2, name: "Bad", defaultImage: "BadUnselect", selectedImage: ""),
                 SleepMood(rawValue: 3, name: "Ok", defaultImage: "NeutralUnselect", selectedImage: ""),
                 SleepMood(rawValue: 4, name: "Good", defaultImage: "GoodUnselect", selectedImage: ""),
                 SleepMood(rawValue: 5, name: "Awesome", defaultImage: "AwesomeUnselect", selectedImage: "")].reversed()
    }
    
    func selectMood(_ rawValue: Int){
        selectedMood = rawValue
    }
}

public struct SleepMood {
    var rawValue : Int
    var name : String
    var defaultImage : String
    var selectedImage : String
}
