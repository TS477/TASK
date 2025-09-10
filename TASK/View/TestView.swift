//
//  TestView.swift
//  Demo
//
//  Created by TSOvO on 29/8/2025.
//

import SwiftUI

struct TestView: View {
    @State private var response: String = "点击按钮开始"
    
    var body: some View {
        VStack {
            Text(response)
                .padding()
            
            Button("发送消息") {
                AIModel.sendMessage(question: "你知道我是誰嗎") { text in
                    self.response = text
                }
            }
        }
    }
}



#Preview {
    TestView()
}
