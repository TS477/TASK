//
//  SwiftUITextEditor.swift
//  Demo
//
//  Created by TSOvO on 27/8/2025.
//

import SwiftUI

struct SwiftUITextEditor: View {
    @State var text: String = ""
    
    var body: some View {
        
        ZStack {
            // text editor
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .frame(width: 300, height: 300)
                    .padding(10)
                
                if text.isEmpty {
                    Text("請輸入")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .font(.system(size: 24))
                        .padding()
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(style: StrokeStyle(lineWidth: 2))
            )
        }
    }
}

#Preview {
    SwiftUITextEditor()
}
