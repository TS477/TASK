//
//  SwiftUIActionSheet.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct SwiftUIActionSheet: View {
    @State var isPresented: Bool = false
    
    var body: some View {

        Button(action: {
            isPresented.toggle()
        }) {
            VStack {
                Image(systemName: "photo.badge.plus")
                    .font(.system(size: 44))
                    .foregroundColor(.gray)
                
                Text("上傳照片")
                    .foregroundColor(.gray)
            }
            .padding(26)
            .background(Color.gray.opacity(0.25))
            .cornerRadius(20)
        }
        .actionSheet(isPresented: $isPresented, content: { actionSheet })
    }
    
    private var actionSheet: ActionSheet {
        let action = ActionSheet(
            title: Text("更多操作"),
            buttons: [
                .default(Text("打開相機"), action: {
                    
                }),
                
                .cancel(Text("取消"), action: {
                    
                }),
                
                .destructive(Text("從相簿選取"), action: {
                    
                })
            ])
        
        return action
    }
}

#Preview {
    SwiftUIActionSheet()
}
