//
//  TASKApp.swift
//  TASK
//
//  Created by TSOvO on 30/8/2025.
//

import SwiftUI

@main
struct TASKApp: App {
    // 創建實例
    @StateObject var navigationManager = Navigation()
    @StateObject var userViewModel = UserViewModel(userModel: UserModel())
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(navigationManager)  // 注入導航管理器
                .environmentObject(userViewModel)      // 注入用戶視圖模型
        }
    }
}
