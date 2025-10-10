//
//  EventJoin.swift
//  TASK
//
//  Created by CHEUNG Ka Tsun on 1/9/2025.
//

import SwiftUI

struct EventJoin: View {
    @State var inputText: String = ""
    @State var recieveText: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                // text editor
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $recieveText)
                        .frame(maxWidth: UIScreen.main.bounds.height-100,maxHeight: UIScreen.main.bounds.height-100)
                        .padding(10)
                    if recieveText.isEmpty {
                        Text("")
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
            ZStack(alignment: .trailing) {
                TextField("請輸入", text: $inputText)
                    .padding()
                    .background(.gray.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.horizontal)
                
                Button {
                    AIModel.sendMessage(question: inputText) { text in
                        self.recieveText = text
                    }
                    recieveText = ""
                } label: {
                    Image(systemName: "arrowshape.turn.up.left.circle.fill")
                        .font(.system(size: 40))
                        .padding(.trailing, 30)
                }
            }
        }
    }
}

#Preview {
    EventJoin()
}
