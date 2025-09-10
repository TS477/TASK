//
//  EventOption.swift
//  TASK
//
//  Created by CHEUNG Ka Tsun on 1/9/2025.
//
import SwiftUI

struct EventOption: View {
    @State private var selectedEvent: String = "hahaha"
    @State private var selectedOption: String = ""
    @EnvironmentObject var buttomNavigation:Navigation
    
    // 定義按鈕數據
    let buttons = [
        ("聊天室", "message.fill", Color.red),
        ("AI Chat", "brain.head.profile", Color.blue),
        ("互評", "star.fill", Color.yellow),
        ("問卷調查", "doc.fill", Color.green)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                titleBar
                Spacer()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 25) {
                    ForEach(buttons, id: \.0) { title, icon, color in
                        NavigationButton(
                            title: title,
                            icon: icon,
                            color: color,
                            action: { handleButtonTap(title) }
                        )
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
    
    private func handleButtonTap(_ title: String) {
        selectedOption = title
        // 根據不同的按鈕執行相應操作
        switch title {
        case "聊天室":
            print("打開聊天室")
        case "AI Chat":
            buttomNavigation.changeView(AnyView(AIChatView()), needButtomNavigation: true)
        case "互評":
            print("打開互評功能")
        case "問卷調查":
            print("打開問卷調查")
        default:
            break
        }
    }
}

private extension EventOption {
    var titleBar: some View {
        HStack {
            Label(selectedEvent, systemImage: "person.3")
                .font(.title.bold())
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Text(selectedOption.isEmpty ? "選擇功能" : selectedOption)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.trailing)
        }
    }
}

// 獨立的按鈕組件
struct NavigationButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .padding(.bottom, 5)
                
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(.white)
            .frame(width: 180, height: 120)
            .background(color.opacity(0.9))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}

// 預覽
struct EventOption_Previews: PreviewProvider {
    static var previews: some View {
        EventOption().environmentObject(Navigation())
    }
}
