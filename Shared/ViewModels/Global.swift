//
//  Global.swift
//  The Sleep Synopsis
//
//  Created by Tom Knighton on 02/08/2022.
//

import Foundation

public class GlobalData: ObservableObject {
    
    public static let shared: GlobalData = GlobalData()
    
    @Published public var CurrentUser: User?
    
    public func SetCurrentUser(to User: User) {
        self.CurrentUser = User
    }
    
    public func RemoveUser() {
        self.CurrentUser = nil
    }
}
