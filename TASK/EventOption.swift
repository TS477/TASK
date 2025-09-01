//
//  EventOption.swift
//  TASK
//
//  Created by CHEUNG Ka Tsun on 1/9/2025.
//

import SwiftUI

struct EventOption: View {
    var body: some View {
        VStack {
            HStack{
                Button{
                    
                }label: {
                    Text("聊天室")
                }.font(.title)
                    .foregroundColor(.black)
                    .frame(width: 150, height: 100)
                    .background(Color.red.opacity(0.9))
                    .cornerRadius(20)
                Button{
                }
                label: {
                    Text("AI Chat")
                }.font(.title)
                    .foregroundColor(.black)
                    .frame(width: 150, height: 100)
                    .background(Color.blue.opacity(0.9))
                    .cornerRadius(20)
            }
            HStack{
                Button{
                    
                }label: {
                    Text("互評")
                }.font(.title)
                    .foregroundColor(.black)
                    .frame(width: 150, height: 100)
                    .background(Color.yellow.opacity(0.9))
                    .cornerRadius(20)
                Button{
                }
                label: {
                    Text("問卷調查")
                }.font(.title)
                    .foregroundColor(.black)
                    .frame(width: 150, height: 100)
                    .background(Color.green.opacity(0.9))
                    .cornerRadius(20)
            }
        }
    }
}

#Preview {
    EventOption()
}
