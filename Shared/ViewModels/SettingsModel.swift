//
//  SettingsModel.swift
//  The Sleep Synopsis (iOS)
//
//  Created by MAJA KOSTACINSKA and Tom Knighton on 29/07/2022.
//

import Foundation

public class SettingsModel : ObservableObject {
    @Published var name : String = ""
    @Published var pass : String = ""
    @Published var bedtime : Date = Date()
    @Published var waketime : Date = Date()
    
    func save() { // Local storage :)
        UserDefaults.standard.set(self.name, forKey: "username")
        UserDefaults.standard.set(self.bedtime, forKey: "bedtime")
        UserDefaults.standard.set(self.waketime, forKey: "waketime")
    }
    
    func setup() {
        self.name = UserDefaults.standard.string(forKey: "username") ?? ""
        self.bedtime = UserDefaults.standard.value(forKey: "bedtime") as? Date ?? Date()
        self.waketime = UserDefaults.standard.value(forKey: "waketime") as? Date ?? Date()
    }
    
    var showButton : Bool {
        if(name != UserDefaults.standard.string(forKey: "username") ||
           bedtime != UserDefaults.standard.value(forKey: "bedtime") as? Date ?? Date() ||
           waketime != UserDefaults.standard.value(forKey: "waketime") as? Date ?? Date())
        {
            return true
        }
        return false
    }
}
