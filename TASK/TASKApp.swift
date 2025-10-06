//
//  TASKApp.swift
//  TASK
//
//  Created by TSOvO on 30/8/2025.
//

import SwiftUI

@main
struct TASKApp: App {
    @StateObject var userViewModel = UserViewModel(userModel: UserModel())
    @StateObject var postViewModel = PostViewModel(posts: [])
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(userViewModel)
                .environmentObject(postViewModel)
        }
    }
    
    init() {
        // 鎖定為橫向
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
    }
}
