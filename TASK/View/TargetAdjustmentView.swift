//
//  TargetAdjustmentView.swift
//  TASK
//
//  Created by Yi Fong Chan on 13/9/2025.
//

import SwiftUI

struct TargetAdjustmentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    // 示例数据
    let totalValue: Int = 30
    let targetPackage = "目標套餐A"
    let description = "這是目標套餐的詳細描述信息，可以包含多行內容。"
    
    // 八个属性示例数据
    let attributes = [
        ("學習能力", 8),
        ("創造力", 7),
        ("團隊合作", 9),
        ("表達能力", 6),
        ("解決問題", 8),
        ("時間管理", 7),
        ("領導力", 5),
        ("適應能力", 9)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 顶部头像和学生资料区域
                VStack {
                    // 头像
                    AsyncImage(url: URL(string: "\(userViewModel.mainUrl + userViewModel.iconUrl + String(userViewModel.id)).png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        // 加載中的佔位符
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                    
                    /*
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                    */
                     
                    // 学生姓名和ID
                    Text(userViewModel.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Student ID: \(userViewModel.id)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                }
                .padding()
                .background(Color(.systemGray6))
                
                // 目标套餐描述区域
                VStack(alignment: .leading, spacing: 10) {
                    Text(targetPackage)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                .padding()
                
                // 八个属性区域
                Text("屬性調整")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                    ForEach(0..<attributes.count, id: \.self) { index in
                        AttributeView(
                            name: attributes[index].0,
                            value: attributes[index].1,
                            total: 10
                        )
                    }
                }
                .padding()
                
                // 提交按钮
                Button(action: {
                    // 提交操作
                }) {
                    Text("提交")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("2024－2025第一學期")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 属性视图组件（保持不变）
struct AttributeView: View {
    let name: String
    @State var value: Int
    let total: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("\(value)/\(total)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            // 进度条
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 6)
                    .cornerRadius(3)
                
                Rectangle()
                    .fill(progressColor)
                    .frame(width: CGFloat(value) / CGFloat(total) * 100, height: 6)
                    .cornerRadius(3)
            }
            
            // 调整按钮
            HStack {
                Button(action: {
                    if value > 0 { value -= 1 }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button(action: {
                    if value < total { value += 1 }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .font(.title3)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
    
    // 根据进度值返回颜色
    private var progressColor: Color {
        let progress = Double(value) / Double(total)
        if progress >= 0.8 {
            return .green
        } else if progress >= 0.5 {
            return .blue
        } else {
            return .orange
        }
    }
}

#Preview {
    TargetAdjustmentView()
        .environmentObject(UserViewModel(userModel: UserModel()))
}
