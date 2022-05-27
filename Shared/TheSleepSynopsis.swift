//
//  TheSleepSynopsis.swift
//  The Sleep Synopsis
//
//  Created by Maja Kostacinska on 30/04/2022.
//

import Foundation

public class TheSleepSynopsis {
    
    ///  Return the bedtime set by the user in the (HH, mm) format.
    public static func getBedtime() -> (Int, Int) {
        
        // Guard statements are basically if statements that have to throw or return if they fail, useful for making sure values
        // are the right type, like here
        // UserDefaults.standard.value returns Any? type (as it cannot know what was set), but we need to make sure it is Date
        // If it is not, method will return (0,0), outside of the guard statement we know bedTime is definitely a Date let
        guard let bedTime = UserDefaults.standard.value(forKey: "bedtime") as? Date else {
            return (0, 0)
        }
        
        return (Calendar.current.component(.hour, from: bedTime), Calendar.current.component(.minute, from: bedTime))
    }
    
    ///  Return the wake time set by the user in the (HH, mm) format.
    public static func getWaketime() -> (Int, Int) {
        guard let wakeTime = UserDefaults.standard.value(forKey: "waketime") as? Date else {
            return (0, 0)
        }
        
        return (Calendar.current.component(.hour, from: wakeTime), Calendar.current.component(.minute, from: wakeTime))
    }
}
