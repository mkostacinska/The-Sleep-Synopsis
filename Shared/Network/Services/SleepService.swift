//
//  SleepService.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 03/08/2022.
//

import Foundation

public struct SleepService {
    
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
    
    /// Returns sleep entries for a specified user
    /// - Parameter userUUID: The UUID of the user
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
    
    /// Creates a new sleep entry for the current user
    /// - Parameter sleepEntry: The details of the new sleep entry to post
    public static func PostSleepEntry(_ sleepEntry: SleepEntry) async -> SleepEntry? {
        do {
            var request = APIRequest(method: .post, path: "sleep")
            request.body = sleepEntry.jsonEncode()
            return try await APIClient.shared.perform(request, to: SleepEntry.self)
        } catch {
            return nil
        }
    }
    
    /// Returns the SleepEntry with the specified UUID
    /// - Parameter sleepUUID: the UUID of the SleepEntry
    public static func GetSleep(_ sleepUUID: String) async -> SleepEntry? {
        do {
            let request = APIRequest(method: .get, path: "sleep/\(sleepUUID)")
            return try await APIClient.shared.perform(request, to: SleepEntry.self)
        } catch {
            return nil
        }
    }
    
    /// Returns the dream with the specified UUID
    /// - Parameter dreamUUID: The UUID of the dream
    public static func GetDream(_ dreamUUID: String) async -> Dream? {
        do {
            let request = APIRequest(method: .post, path: "sleep/dreams/\(dreamUUID)")
            return try await APIClient.shared.perform(request, to: Dream.self)
        } catch {
            return nil
        }
    }
    
    /// Modifies/Updates a dream's details
    /// - Parameter details: The UUID, new title and text of the dream
    public static func ModifyDream(details: EditDreamDTO) async -> Dream? {
        do {
            var request = APIRequest(method: .post, path: "sleep/dreams\(details.dreamUUID)/modify")
            request.body = details.jsonEncode()
            return try await APIClient.shared.perform(request, to: Dream.self)
        } catch {
            return nil
        }
    }
}
