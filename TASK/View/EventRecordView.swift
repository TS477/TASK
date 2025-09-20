//
//  EventRecordView.swift
//  TASK
//
//  Created by Yi Fong Chan on 14/9/2025.
//

import SwiftUI

struct EventRecordView: View {
    var body: some View {
        NavigationView {
            ActivityListsView(activities: createSampleActivities())
        }
        .navigationViewStyle(.stack)
    }
}

// 定义能力枚举
enum Ability: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case learning = "學習能力"
    case creativity = "創造力"
    case teamwork = "團隊合作"
    case expression = "表達能力"
    case problemSolving = "解決問題"
    case timeManagement = "時間管理"
    case leadership = "領導力"
    case adaptability = "適應能力"
}

// 定义评语结构
struct ActivityComment: Identifiable {
    let id = UUID()
    let author: String
    let content: String
}

// 定义活动结构
struct ActivityItem: Identifiable {
    let id = UUID()
    let date: Date
    let name: String
    let abilities: [Ability]
    let comments: [ActivityComment]
}

// 主列表视图
struct ActivityListsView: View {
    let activities: [ActivityItem]
    
    // 日期格式化
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "zh_Hant_TW")
        return formatter
    }
    
    var body: some View {
        List {
            ForEach(activities) { activity in
                NavigationLink(destination: ActivityDetailView(activity: activity)) {
                    ActivityItemRow(activity: activity, dateFormatter: dateFormatter)
                }
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("活動記錄")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("活動記錄")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
            }
        }
    }
}

// 活动行视图
struct ActivityItemRow: View {
    let activity: ActivityItem
    let dateFormatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 日期和活动名称
            HStack(alignment: .top) {
                Text(dateFormatter.string(from: activity.date))
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(activity.name)
                    .font(.system(size: 20, weight: .semibold))
                    .multilineTextAlignment(.trailing)
            }
            
            // 能力标签
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(activity.abilities) { ability in
                        Text(ability.rawValue)
                            .font(.system(size: 18))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(12)
                    }
                }
            }
            
            // 评语预览
            if !activity.comments.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    Text("評語:")
                        .font(.system(size: 18))
                        .foregroundColor(.secondary)
                    
                    Text(activity.comments[0].content)
                        .font(.system(size: 18))
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                    
                    if activity.comments.count > 1 {
                        Text("還有 \(activity.comments.count - 1) 條評語...")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding(.vertical, 12)
    }
}

// 活动详情视图
struct ActivityDetailView: View {
    let activity: ActivityItem
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "zh_Hant_TW")
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 活动标题和日期
                VStack(alignment: .leading, spacing: 12) {
                    Text(activity.name)
                        .font(.system(size: 24, weight: .bold))
                    
                    Text(dateFormatter.string(from: activity.date))
                        .font(.system(size: 20))
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // 能力标签
                VStack(alignment: .leading, spacing: 12) {
                    Text("相關能力")
                        .font(.system(size: 22, weight: .semibold))
                    
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 140, maximum: 160), spacing: 12)
                    ], spacing: 12) {
                        ForEach(activity.abilities) { ability in
                            Text(ability.rawValue)
                                .font(.system(size: 20))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(20)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                
                Divider()
                
                // 评语
                VStack(alignment: .leading, spacing: 16) {
                    Text("評語")
                        .font(.system(size: 22, weight: .semibold))
                    
                    ForEach(activity.comments) { comment in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(comment.author)
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text(comment.content)
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                        }
                        .padding(16)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle("活動詳情")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("活動詳情")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
            }
        }
    }
}

// 创建示例数据的函数
func createSampleActivities() -> [ActivityItem] {
    let calendar = Calendar.current
    
    let date1 = calendar.date(from: DateComponents(year: 2024, month: 1, day: 4))!
    let date2 = calendar.date(from: DateComponents(year: 2024, month: 4, day: 12))!
    let date3 = calendar.date(from: DateComponents(year: 2024, month: 5, day: 3))!
    
    return [
        ActivityItem(
            date: date1,
            name: "義工探訪",
            abilities: [.teamwork, .expression, .adaptability],
            comments: [
                ActivityComment(author: "余老師", content: "同學表現積極，主動與長者交流"),
                ActivityComment(author: "王老師", content: "同學很有耐心，值得表揚")
            ]
        ),
        ActivityItem(
            date: date2,
            name: "家際問答",
            abilities: [.learning, .problemSolving, .timeManagement],
            comments: [
                ActivityComment(author: "曾同學", content: "題目很有挑戰性，但我們合作得很好")
            ]
        ),
        ActivityItem(
            date: date3,
            name: "閱讀比賽",
            abilities: [.creativity, .expression, .leadership],
            comments: [
                ActivityComment(author: "余老師", content: "同學的創意表達令人印象深刻"),
                ActivityComment(author: "王老師", content: "同學能夠快速適應比賽環境"),
                ActivityComment(author: "曾同學", content: "這次比賽讓我學到了很多")
            ]
        )
    ].sorted(by: { $0.date > $1.date })
}

// 预览
struct EventRecordView_Previews: PreviewProvider {
    static var previews: some View {
        EventRecordView()
    }
}
