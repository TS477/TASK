//
//  TestView.swift
//  Demo
//
//  Created by TSOvO on 29/8/2025.
//

import SwiftUI

struct TestView: View {
    enum AppSection: String, CaseIterable, Identifiable {
        case home = "首頁"
        case profile = "個人資料"
        case search = "搜尋"
        case allEvent = "活動一覽"
        
        var id: String { rawValue }
        var icon: String {
            switch self {
            case .home: return "house.fill"
            case .profile: return "person.fill"
            case .search: return "magnifyingglass"
            case .allEvent: return "figure.2"
            }
        }
    }
    
    @State private var selectedSection: AppSection? = .home
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedSection) {
                ForEach(AppSection.allCases) { section in
                    NavigationLink(value: section) {
                        Label(section.rawValue, systemImage: section.icon)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("導航")
        } detail: {
            Group {
                if let section = selectedSection {
                    switch section {
                    case .home:
                        HomePageView()
                    case .profile:
                        ProfileView()
                    case .search:
                        Text("搜索內容待完成")
                    case .allEvent:
                        Text("活動一覽")
                    }
                } else {
                    ContentUnavailableView(
                        "請選擇一個項目",
                        systemImage: "square.grid.2x2",
                        description: Text("從左側選單中選擇要查看的內容")
                    )
                }
            }
        }
    }
}

#Preview {
    TestView()
        .environmentObject(UserViewModel(userModel: UserModel()))
        .environmentObject(PostViewModel(posts: []))
}
