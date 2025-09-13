//
//  TargetSelectionView.swift
//  TASK
//
//  Created by Yi Fong Chan on 13/9/2025.
//

import SwiftUI

struct TargetSelectionView: View {
    @State private var goalText = ""
    @State private var chatText = ""
    @State private var messages: [String] = []
    
    // 六個目標套餐
    let packages = [
        ("目標套餐A", "heart.fill", Color.red),
        ("目標套餐B", "briefcase.fill", Color.blue),
        ("目標套餐C", "book.fill", Color.green),
        ("目標套餐D", "dollarsign.circle.fill", Color.orange),
        ("目標套餐E", "person.2.fill", Color.purple),
        ("目標套餐F", "brain.head.profile", Color.indigo)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部 - 目標設定
            VStack {
                Text("設定你的目標")
                    .font(.title2)
                    .bold()
                
                TextField("輸入你的目標...", text: $goalText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            
            // 中間 - 目標套餐
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(packages, id: \.0) { package in
                        PackageButton(title: package.0, icon: package.1, color: package.2) {
                            goalText = package.0
                        }
                    }
                }
                .padding()
            }
            
            // 底部 - AI聊天
            VStack {
                Divider()
                
                // 簡化的聊天顯示
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(messages, id: \.self) { message in
                            Text(message)
                                .padding(8)
                                .background(message.hasPrefix("你:") ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity, alignment: message.hasPrefix("你:") ? .trailing : .leading)
                        }
                    }
                    .padding()
                }
                .frame(height: 400)
                
                HStack {
                    TextField("問AI關於目標的建議...", text: $chatText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.1))
        }
    }
    
    func sendMessage() {

        guard !chatText.isEmpty else { return }
        
        var history: String = messages.reduce("") { result, message in
            result + message + "\n"
        }
        
        // 用戶訊息
        messages.append("你: \(chatText)")

        
        AIModel.sendMessage(question: (history + "The above is the chat record between AI and users\n" + chatText)){ text in
            let aiResponse = "AI: \(text)"
            messages.append(aiResponse)
            
        }
        
        chatText = ""
    }
    
}

// 套餐按鈕組件
struct PackageButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(color)
                    .clipShape(Circle())
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

// 預覽
#Preview {
    TargetSelectionView()
}
