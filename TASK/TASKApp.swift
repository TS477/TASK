//
//  TASKApp.swift
//  TASK
//
//  Created by TSOvO on 30/8/2025.
//

import SwiftUI

@main
struct TASKApp: App {
    @StateObject var navigation = Navigation()
    @StateObject var userViewModel = UserViewModel(userModel: UserModel())
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(navigation)
                .onAppear {
                    // 一個一個註冊 ViewModel
                    navigation.register(userViewModel)
                    // 未來有新的 ViewModel 就再加一行
                    
                    // 轉畫面
                    navigation.changeView(AnyView(HomePageView()), needButtomNavigation: true)
                }
        }
    }
}
