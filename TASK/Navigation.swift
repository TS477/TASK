//
//  ButtomNavigation.swift
//  TASK
//
//  Created by TSOvO on 3/9/2025.
//

import SwiftUI

// NavigationManager 類
class Navigation: ObservableObject {
    @Published var currentView: AnyView = AnyView(Text("error"))
    @Published var needButtomNavigation: Bool = true
    
    // 簡單的陣列存儲所有需要注入的 ViewModel
    private var viewModels: [AnyObject] = []
    
    // 註冊 ViewModel
    func register(_ viewModel: AnyObject) {
        viewModels.append(viewModel)
    }
    
    func changeView(_ view: AnyView, needButtomNavigation: Bool) {
        var finalView = view
        
        // 為視圖一個一個注入所有 ViewModel
        for viewModel in viewModels {
            if let observable = viewModel as? (any ObservableObject) {
                finalView = AnyView(finalView.environmentObject(observable))
            }
        }
        
        self.currentView = finalView
        self.needButtomNavigation = needButtomNavigation
    }
}
