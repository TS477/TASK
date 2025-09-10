//
//  SwiftUIButton.swift
//  Demo
//
//  Created by TSOvO on 26/8/2025.
//

import SwiftUI

struct SwiftUIButton: View {
    @State private var count: Int = 0
    private var addNum: Int = 1
    
    var body: some View {
        VStack(spacing: 50) {
            // first button
            Button(action: {
                
            }) {
                Text("這是一個按鈕")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(
                        LinearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(30)
            }
            
            // second button
            VStack(spacing: 20) {
                Text("功德: " + String(count))
                    .font(.system(size: 32))
                    .bold()
                
                Button(action: {
                    self.count += self.addNum
                }) {
                    ZStack {
                        Color.brown
                            .scaledToFit()
                            .frame(width: 300)
                        
                        Image("WoodenFish")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    }
                    .cornerRadius(30)
                     
                    }
            }
        }
    }
}

#Preview {
    SwiftUIButton()
}
