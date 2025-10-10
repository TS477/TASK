//
//  TASKApp.swift
//  TASK
//
//  Created by TSOvO on 30/8/2025.
//

import SwiftUI

@main
struct TASKApp: App {
    // 創建共享的服務層實例
    @StateObject private var userService = UserService()
    
    // 創建 ViewModel，注入同一個服務層實例
    var userViewModel: UserViewModel {
        UserViewModel(userService: userService)
    }
    
    var postViewModel: PostViewModel {
        PostViewModel(userService: userService)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(userService)  // 傳遞服務層
                .environmentObject(userViewModel) // 傳遞 ViewModel
                .environmentObject(postViewModel) // 傳遞 ViewModel
        }
    }
    
    init() {
        // 鎖定為橫向
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
    }
}
