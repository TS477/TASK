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
    
    var body: some View {
        VStack {
            titleBar
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 1000, maximum: 200)), count: 2), spacing: 10) {
                
                NavigationLink(destination: EmptyView()) {
                    NavigationButton(
                        title: "聊天室",
                        icon: "message.fill",
                        color: .red
                    )
                }
                .simultaneousGesture(TapGesture().onEnded {
                    handleButtonTap("聊天室")
                })
                
                NavigationLink(destination: AIChatView()) {
                    NavigationButton(
                        title: "AI Chat",
                        icon: "brain.head.profile",
                        color: .blue
                    )
                }
                .simultaneousGesture(TapGesture().onEnded {
                    handleButtonTap("AI Chat")
                })
                
                NavigationLink(destination: EventEvaluationView(activity: sampleActivity)) {
                    NavigationButton(
                        title: "互評",
                        icon: "star.fill",
                        color: .yellow
                    )
                }
                .simultaneousGesture(TapGesture().onEnded {
                    handleButtonTap("互評")
                })
                
                NavigationLink(destination: EmptyView()) {
                    NavigationButton(
                        title: "問卷調查",
                        icon: "doc.fill",
                        color: .green
                    )
                }
                .simultaneousGesture(TapGesture().onEnded {
                    handleButtonTap("問卷調查")
                })
            }
            .padding()
            
            Spacer()
        }
        .navigationViewStyle(.stack)
    }
    
    private func handleButtonTap(_ title: String) {
        selectedOption = title
        // 根據不同的按鈕執行相應操作
        switch title {
        case "聊天室":
            print("打開聊天室")
        case "AI Chat":
            print("打開AI聊天室")
        case "互評":
            print("打開互評")
        case "問卷調查":
            print("打開問卷調查")
        default:
            break
        }
    }
}

// 修改 NavigationButton，移除 Button
struct NavigationButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
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

// 預覽
struct EventOption_Previews: PreviewProvider {
    static var previews: some View {
        EventOption()
    }
}
