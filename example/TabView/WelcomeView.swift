//
//  WelcomeView.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct WelcomeView: View {
    var welComCards: [WelcomeCardView] = [
        WelcomeCardView(sentence: "人生好難"),
        WelcomeCardView(sentence: "總是有大大小小的困難"),
        WelcomeCardView(sentence: "但是管他的")
    ]
    
    var body: some View {
        VStack {
            // TabView 需要明确的高度
            TabView {
                ForEach(welComCards) { card in
                    card
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .frame(height: 300) // 添加明确的高度
            
            Spacer()
            
            ImmeidatelyStartButton()
                .padding(.bottom, 40)
        }
    }
}

struct WelcomeCardView: View, Identifiable {
    var sentence: String = ""
    var id: UUID = UUID()
    
    var body: some View {
        VStack {
            Text(sentence)
                .font(.system(size: 36))
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
}

struct ImmeidatelyStartButton: View {
    var body: some View {
        Button(action: {
            // code
        }) {
            Text("立即開始")
                .font(.system(size: 24))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: 30)
                .padding()
                .background(
                    Color.red
                        .opacity(0.8)
                )
                .cornerRadius(30)
                .padding(.horizontal, 22)
        }
    }
}

#Preview {
    WelcomeView()
}
