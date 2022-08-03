//
//  SleepService.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 03/08/2022.
//

import Foundation

public struct SleepService {
    
//    public static func CreateSleepEntry(_ dto: SleepE)
    
    
    /// Returns sleep entries for the current logged in user
    public static func MySleepEntries() async -> [SleepEntry]? {
        guard let _ = GlobalData.shared.CurrentUser?.userUUID else {
            return nil
        }
        
        do {
            let request = APIRequest(method: .get, path: "sleep/mine")
            return try await APIClient.shared.perform(request, to: [SleepEntry].self)
        } catch {
            return nil
        }
    }
    
    public static func SleepEntries(for userUUID: String) async -> [SleepEntry]? {
        guard let _ = GlobalData.shared.CurrentUser?.userUUID else {
            return nil
        }
        
        do {
            let request = APIRequest(method: .get, path: "sleep/User/\(userUUID)")
            return try await APIClient.shared.perform(request, to: [SleepEntry].self)
        } catch {
            return nil
        }
    }
}
