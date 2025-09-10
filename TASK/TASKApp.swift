//
//  TASKApp.swift
//  TASK
//
//  Created by TSOvO on 30/8/2025.
//

import SwiftUI

@main
struct TASKApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(ButtomNavigation())
                .environmentObject(UserViewModel(userModel: UserModel()))
        }
    }
}
