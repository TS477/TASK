//
//  TapView.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

// 整體管理的視圖
struct MainView: View {
    // 用於底部導航的屬性
    let myTabs: [(icon: String, title: String, targetView: AnyView)] = [
        (icon: "house.fill", title: "首頁", targetView: AnyView(HomePageView())),
        (icon: "magnifyingglass", title: "搜尋", targetView: AnyView(Text("搜索內容待完成"))),
        (icon: "brain.filled.head.profile", title: "提案", targetView: AnyView(Text("提案內容待完成"))),
        (icon: "apple.meditate", title: "未知", targetView: AnyView(Text("未知內容"))),
        (icon: "figure.2", title: "活動一覽", targetView: AnyView(Text("活動一覽")))
    ]
    
    @EnvironmentObject var navigation: Navigation
    
    var body: some View {
        VStack() {
            navigation.currentView
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 顯示現在的畫面
            
            if navigation.needButtomNavigation { // 根據需求決定是否顯示底部引導
                CustomTabBar(tabs: myTabs).offset(y: 20)
            }
        }
        

    }
    
    // 自定義底部導航欄
    private struct CustomTabBar: View {
        // 傳入的 tab 項目，(系統圖標名稱, 標題)
        let tabs: [(icon: String, title: String, targetView: AnyView)]
        
        @EnvironmentObject var buttomNavigation: Navigation
        
        // 底部現在索引
        @State var currentTabIndex: Int = 0
        
        // 當前選中索引（綁定）
        // @Binding var selectedIndex: Int
        
        // 圖標大小和文字大小（可選參數，預設值）
        let iconSize: CGFloat = 28 // 圖標顏色
        let fontSize: CGFloat = 12 // 字體顏色
        
        // 顏色（可選）
        let selectedColor: Color = .blue // 已選擇顏色
        let unselectedColor: Color = .gray // 未選擇顏色
        
        var body: some View {
            
            // 設置圖標各自的距離
            HStack(spacing: 36) {
                ForEach(tabs.indices, id: \.self) { index in
                    Button(action: {
                        buttomNavigation.changeView(tabs[index].targetView, needButtomNavigation: true) // 改變畫面
                        currentTabIndex = index // 改變索引
                    }) {
                        VStack(spacing: 4) {
                            
                            Image(systemName: tabs[index].icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: iconSize, height: iconSize)
                                .foregroundColor(currentTabIndex == index ? selectedColor : unselectedColor)
                            
                            Text(tabs[index].title)
                                .font(.system(size: fontSize))
                                .foregroundColor(currentTabIndex == index ? selectedColor : unselectedColor)
                        }
                    }
                }
            }
<<<<<<< HEAD
            .background(Color(UIColor.systemBackground))
=======
            .listStyle(.sidebar)
            .navigationTitle("目錄")
        } detail: {
            Group {
                if let section = selectedSection {
                    switch section {
                    case .home:
                        HomePageView()
                            .onAppear() {
                            }
                    case .menu:
                        MenuView(isLoggedIn: $isLoggedIn)
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
>>>>>>> parent of a5825e9 (修改MainView)
        }
    }
}

#Preview {
    let navigation = Navigation()
    let userViewModel = UserViewModel(userModel: UserModel()) // 創建獨立的 ViewModel 實例
    let postViewModel = PostViewModel(posts: [])
    
    return MainView()
        .environmentObject(navigation)
        .onAppear {
            // 註冊 ViewModel
            navigation.register(userViewModel)
            navigation.register(postViewModel)
            // 初始化畫面
            navigation.changeView(AnyView(AppLoginView()), needButtomNavigation: false)
        }
}
