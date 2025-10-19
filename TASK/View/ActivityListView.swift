//
//  AvailableEventView.swift
//  TASK
//
//  Created by CHEUNG Ka Tsun on 3/9/2025.
//

import SwiftUI

// 活動模型
struct Activitysp: Identifiable {
    let id = UUID()
    let name: String
    let source: String
    let abilities: [Bool] // 8個布林值，表示是否有對應能力
}

// 主視圖
struct ActivityListView: View {
    // 範例數據
    let activities: [Activitysp] = [
        Activitysp(
            name: "團隊建設",
            source: "公司",
            abilities: [true, true, false, true, false, true, true, false]
        ),
        Activitysp(
            name: "技術分享",
            source: "技術部",
            abilities: [false, true, true, false, true, false, true, true]
        ),
        Activitysp(
            name: "產品發佈會",
            source: "市場部",
            abilities: [true, false, true, true, false, true, false, true]
        ),
        Activitysp(
            name: "客戶會議",
            source: "銷售部",
            abilities: [false, true, false, true, true, false, true, false]
        ),
        Activitysp(
            name: "培訓課程",
            source: "人力資源",
            abilities: [true, true, true, false, false, true, true, true]
        ),
        Activitysp(
            name: "年度總結",
            source: "管理層",
            abilities: [true, false, true, false, true, false, true, false]
        ),
        Activitysp(
            name: "創新研討會",
            source: "研發部",
            abilities: [false, true, false, true, false, true, false, true]
        ),
        Activitysp(
            name: "慶功宴",
            source: "全體員工",
            abilities: [true, true, true, true, false, false, false, true]
        )
    ]
    
    // 能力顏色陣列
    let abilityColors: [Color] = [
        .red, .blue, .green, .yellow,
        .orange, .purple, .pink, .gray
    ]
    
    // 用於iPad的網格佈局
    @State private var isGridViewActive = false
    
    var body: some View {
        NavigationView {
            Group {
                if isGridViewActive && UIDevice.current.userInterfaceIdiom == .pad {
                    gridView
                } else {
                    listView
                }
            }
            .navigationTitle("活動一覽")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Button(action: {
                            withAnimation {
                                isGridViewActive.toggle()
                            }
                        }) {
                            Image(systemName: isGridViewActive ? "list.bullet" : "square.grid.2x2")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    // 列表視圖 (iPhone和iPad都可使用)
    private var listView: some View {
        List(activities) { activity in
            ActivityRow(activity: activity, abilityColors: abilityColors)
                .listRowSeparator(.visible)
                .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        }
        .listStyle(PlainListStyle())
    }
    
    // 網格視圖 (僅iPad使用)
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 400, maximum: 500), spacing: 16)
            ], spacing: 16) {
                ForEach(activities) { activity in
                    ActivityCard(activity: activity, abilityColors: abilityColors)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}

// 活動卡片視圖 - 針對iPad優化
struct ActivityCard: View {
    let activity: Activitysp
    let abilityColors: [Color]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 標題區域
            HStack {
                Text(activity.source)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(6)
                
                Spacer()
                
                Image(systemName: "ellipsis.circle")
                    .foregroundColor(.blue)
            }
            
            // 活動名稱
            Text(activity.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            // 能力格子 - 單行顯示
            HStack(spacing: 4) {
                ForEach(0..<8, id: \.self) { index in
                    VStack(spacing: 2) {
                        abilityCircle(for: index)
                        
                        Text("能力 \(index + 1)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 4)
            
            // 底部操作區
            HStack {
                Spacer()
                
                Button(action: {}) {
                    Text("參與")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {}) {
                    Image(systemName: "info.circle")
                        .padding(8)
                        .background(Color.secondary.opacity(0.2))
                        .foregroundColor(.primary)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // 生成能力圓形指示器
    private func abilityCircle(for index: Int) -> some View {
        Circle()
            .fill(activity.abilities[index] ? abilityColors[index] : Color.gray.opacity(0.3))
            .frame(width: 24, height: 24)
            .overlay(
                activity.abilities[index] ?
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                : nil
            )
    }
}

// 單行視圖
struct ActivityRow: View {
    let activity: Activitysp
    let abilityColors: [Color]
    
    var body: some View {
        HStack(spacing: 16) {
            // 左側 - 活動來源
            Text(activity.source)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 60, alignment: .leading)
            
            // 中間 - 活動名稱
            Text(activity.name)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // 右側 - 8個能力格子，分為兩行
            VStack(spacing: 4) {
                // 第一行4個格子
                HStack(spacing: 4) {
                    ForEach(0..<4, id: \.self) { index in
                        abilitySquare(for: index)
                    }
                }
                
                // 第二行4個格子
                HStack(spacing: 4) {
                    ForEach(4..<8, id: \.self) { index in
                        abilitySquare(for: index)
                    }
                }
            }
            .frame(width: 80)
        }
        .padding(.vertical, 8)
    }
    
    // 生成能力格子
    private func abilitySquare(for index: Int) -> some View {
        Rectangle()
            .fill(activity.abilities[index] ? abilityColors[index] : Color.clear)
            .frame(width: 16, height: 16)
            .overlay(
                Rectangle()
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .cornerRadius(3)
    }
}

// 預覽
struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityListView()
                .previewDevice("iPad Pro (11-inch) (4th generation)")
            
            ActivityListView()
                .previewDevice("iPhone 15 Pro")
        }
    }
}
