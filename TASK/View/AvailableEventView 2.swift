//
//  AvailableEventView.swift
//  TASK
//
//  Created by CHEUNG Ka Tsun on 3/9/2025.
//

import SwiftUI

// 活动模型
struct Activitysp: Identifiable {
    let id = UUID()
    let name: String
    let source: String
    let abilities: [Bool] // 8个布尔值，表示是否有对应能力
}

// 主视图
struct ActivityListView: View {
    // 示例数据
    let activities: [Activitysp] = [
        Activitysp(
            name: "团队建设",
            source: "公司",
            abilities: [true, true, false, true, false, true, true, false]
        ),
        Activitysp(
            name: "技术分享",
            source: "技术部",
            abilities: [false, true, true, false, true, false, true, true]
        ),
        Activitysp(
            name: "产品发布会",
            source: "市场部",
            abilities: [true, false, true, true, false, true, false, true]
        ),
        Activitysp(
            name: "客户会议",
            source: "销售部",
            abilities: [false, true, false, true, true, false, true, false]
        ),
        Activitysp(
            name: "培训课程",
            source: "人力资源",
            abilities: [true, true, true, false, false, true, true, true]
        ),
        Activitysp(
            name: "年度总结",
            source: "管理层",
            abilities: [true, false, true, false, true, false, true, false]
        ),
        Activitysp(
            name: "创新研讨会",
            source: "研发部",
            abilities: [false, true, false, true, false, true, false, true]
        ),
        Activitysp(
            name: "庆功宴",
            source: "全体员工",
            abilities: [true, true, true, true, false, false, false, true]
        )
    ]
    
    // 能力颜色数组
    let abilityColors: [Color] = [
        .red, .blue, .green, .yellow,
        .orange, .purple, .pink, .gray
    ]
    
    // 用于iPad的网格布局
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
            .navigationTitle("活动选项")
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
    
    // 列表视图 (iPhone和iPad都可使用)
    private var listView: some View {
        List(activities) { activity in
            ActivityRow(activity: activity, abilityColors: abilityColors)
                .listRowSeparator(.visible)
                .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        }
        .listStyle(PlainListStyle())
    }
    
    // 网格视图 (仅iPad使用)
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

// 活动卡片视图 - 针对iPad优化
struct ActivityCard: View {
    let activity: Activitysp
    let abilityColors: [Color]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 标题区域
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
            
            // 活动名称
            Text(activity.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            // 能力格子 - 单行显示
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
            
            // 底部操作区
            HStack {
                Spacer()
                
                Button(action: {}) {
                    Text("参与")
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
    
    // 生成能力圆形指示器
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

// 单行视图
struct ActivityRow: View {
    let activity: Activitysp
    let abilityColors: [Color]
    
    var body: some View {
        HStack(spacing: 16) {
            // 左侧 - 活动来源
            Text(activity.source)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 60, alignment: .leading)
            
            // 中间 - 活动名称
            Text(activity.name)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // 右侧 - 8个能力格子，分为两行
            VStack(spacing: 4) {
                // 第一行4个格子
                HStack(spacing: 4) {
                    ForEach(0..<4, id: \.self) { index in
                        abilitySquare(for: index)
                    }
                }
                
                // 第二行4个格子
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

// 预览
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
