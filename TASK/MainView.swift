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
    @EnvironmentObject private var navigationManager: NavigationManager
    let myTabs = [ // 設置圖案和標籤
        (icon: "house.fill", title: "首頁"),
        (icon: "magnifyingglass", title: "搜尋"),
        (icon: "brain.filled.head.profile", title: "提案"),
        (icon: "apple.meditate", title: "未知"),
        (icon: "figure.2", title: "活動一覽"),
    ]
    
    var body: some View {
        VStack {
            Group {
                switch self.navigationManager.selectedTab {
                case 0: HomePageView()
                case 1: Text("搜索內容待完成")
                case 2: Text("提案內容待完成")
                case 3: Text("未知內容")
                case 4: Text("活動一覽")
                default: Text("錯誤")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            // 設置y偏移
            CustomTabBar(tabs: myTabs, selectedIndex: self.$navigationManager.selectedTab).offset(y: 20)
        }
        

    }
    
    // 自定義底部導航欄
    private struct CustomTabBar: View {
        // 傳入的 tab 項目，(系統圖標名稱, 標題)
        let tabs: [(icon: String, title: String)]
        
        // 當前選中索引（綁定）
        @Binding var selectedIndex: Int
        
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
                        selectedIndex = index
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: tabs[index].icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: iconSize, height: iconSize)
                                .foregroundColor(selectedIndex == index ? selectedColor : unselectedColor)
                            
                            Text(tabs[index].title)
                                .font(.system(size: fontSize))
                                .foregroundColor(selectedIndex == index ? selectedColor : unselectedColor)
                        }
                    }
                }
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}

// NavigationManager 類
class NavigationManager: ObservableObject {
    @Published var selectedTab: Int = 0
}

#Preview {
    MainView().environmentObject(NavigationManager())
}
