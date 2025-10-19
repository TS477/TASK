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
        VStack(spacing: 30) {
            // 頂部頭像和信息區域 - 修改為水平佈局
            HStack(alignment: .top, spacing: 40) {
                // 頭像在左側
                AsyncImage(url: URL(string: "\(userViewModel.mainUrl + userViewModel.iconUrl + String(userViewModel.id)).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    // 加載中的佔位符
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                        .shadow(radius: 3)
                )
                
                // 學校、姓名、年齡在右側
                VStack(alignment: .leading, spacing: 8) {
                    Text(userViewModel.schoolName)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text(userViewModel.name)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("\(userViewModel.age)歲")
                        .font(.system(size: 20, weight: .bold))
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 15)
            
            // 屬性數值區域
            VStack(alignment: .leading, spacing: 10) {
                Text("屬性數值")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                AttributeRow(
                    color: .red,
                    value: CGFloat(userViewModel.abilityVal1)
                )
                
                AttributeRow(
                    color: .orange,
                    value: CGFloat(userViewModel.abilityVal2)
                )
                
                AttributeRow(
                    color: .yellow,
                    value: CGFloat(userViewModel.abilityVal3)
                )
                AttributeRow(
                    color: .green,
                    value: CGFloat(userViewModel.abilityVal4)
                )
                AttributeRow(
                    color: .cyan,
                    value: CGFloat(userViewModel.abilityVal5)
                )
                AttributeRow(
                    color: .blue,
                    value: CGFloat(userViewModel.abilityVal6)
                )
                AttributeRow(
                    color: .purple,
                    value: CGFloat(userViewModel.abilityVal7)
                )
                AttributeRow(
                    color: .gray,
                    value: CGFloat(userViewModel.abilityVal8)
                )
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
            
            // 套餐選擇框
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

// 屬性行組件
struct AttributeRow: View {
    let color: Color
    let value: CGFloat
    
    var body: some View {
        HStack(spacing: 20) {
            // 顏色頭像
            Circle()
                .fill(color)
                .frame(width: 30, height: 30)
            
            // 進度條
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // 背景條
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 15)
                    
                    // 進度條
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color)
                        .frame(width: geometry.size.width * (value / 100), height: 15)
                }
            }
            .frame(height: 15) // 固定高度與圓點對齊
            
            // 數值顯示
            Text("\(Int(value))%")
                .font(.system(.body, design: .monospaced))
                .frame(width: 30, alignment: .trailing) // 固定寬度確保對齊
        }
        .frame(height: 40) // 固定每行高度
    }
}

#Preview {
    @Previewable @StateObject var userService = UserService()
    
    // 創建 ViewModel，注入同一個服務層實例
    var userViewModel: UserViewModel {
        UserViewModel(userService: userService)
    }
    
    ProfileView()
        .environmentObject(userViewModel)
}
