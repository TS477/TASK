//
//  ProfileView.swift
//  TASK
//
//  Created by TSOvO on 3/9/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
            VStack(spacing: 40) {
                // 顶部头像区域
                VStack(spacing: 10) { // 頭像和名字
                    Image("") // test //////////////
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 2)
                                .shadow(radius: 3)
                        )
                        .padding(.top, 10)
                    
                    Text(userViewModel.name)
                        .font(.system(size: 24, weight: .bold))
                }
                
                
                
                // 属性值区域
                VStack(alignment: .leading, spacing: 15) {
                    Text("屬性數值")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    /*
                    // 属性值列表
                    ForEach(0..<8) { index in
                        AttributeRow(
                            color: attributeColors[index],
                            value: CGFloat.random(in: 0...100),
                            label: "屬性 \(index+1)"
                        )
                    }
                     */
                    
                    AttributeRow(
                        color: .red,
                        // test //////////////
                        value: CGFloat(userViewModel.abilityVal1),
                        // test //////////////
                        )
                    
                    AttributeRow(
                        color: .orange,
                        // test //////////////
                        value: CGFloat(userViewModel.abilityVal2),
                        // test //////////////
                        )
                    
                    AttributeRow(
                        color: .yellow,
                        // test //////////////
                        value: CGFloat(userViewModel.abilityVal3),
                        // test //////////////
                        )
                    AttributeRow(
                        color: .green,
                        // test //////////////
                        value: CGFloat(userViewModel.abilityVal4),
                        // test //////////////
                        )
                    AttributeRow(
                        color: .cyan,
                        // test //////////////
                        value: CGFloat(userViewModel.abilityVal5),
                        // test //////////////
                        )
                    AttributeRow(
                        color: .blue,
                        // test ////////u//////
                        value: CGFloat(userViewModel.abilityVal6),
                        // test //////////////
                        )
                    AttributeRow(
                        color: .purple,
                        // test //////////////
                        value: CGFloat(userViewModel.abilityVal7),
                        // test //////////////
                        )
                    AttributeRow(
                        color: .gray,
                        // test //////////////
                        value: CGFloat(userViewModel.abilityVal8),
                        // test //////////////
                        )
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                // 套餐选择框
                VStack(alignment: .leading, spacing: 10) {
                    Text("當前套餐")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "crown.fill")
                            .foregroundColor(.yellow)
                        
                        Text("套餐 A")
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("進行中")
                            .font(.caption)
                            .padding(5)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(6)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                Spacer()
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("個人檔案")
        }
    }

    // 属性行组件
    struct AttributeRow: View {
        let color: Color
        let value: CGFloat
        
        var body: some View {
            HStack() {
                // 颜色头像
                Circle()
                    .fill(color)
                    .scaledToFit()
                    .frame(width: 20)
                
                // 进度条
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // 背景条
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 8)
                        
                        // 进度条
                        RoundedRectangle(cornerRadius: 4)
                            .fill(color)
                            .frame(width: geometry.size.width * (value / 100), height: 8)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                
                // 数值显示
                Text("\(Int(value))%")
                    .font(.system(.body, design: .monospaced))
                    .frame(width: 50, alignment: .trailing)
            }
        }
}

#Preview {
    ProfileView()
        .environmentObject(UserViewModel(userModel: UserModel()))
}
