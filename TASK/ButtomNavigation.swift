//
//  ButtomNavigation.swift
//  TASK
//
//  Created by TSOvO on 3/9/2025.
//

import SwiftUI

// NavigationManager 類
class ButtomNavigation: ObservableObject {
    @Published var currentView: AnyView = AnyView(HomePageView())
    @Published var needButtomNavigation: Bool = true
    
    func changeView(_ view: AnyView, needButtomNavigation: Bool) {
        self.currentView = view
        self.needButtomNavigation = needButtomNavigation
    }
}
