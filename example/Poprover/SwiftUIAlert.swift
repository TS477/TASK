//
//  SwiftUIAlert.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct SwiftUIAlert: View {
    @State var isShowingDeleteAlert: Bool = false
    
    var body: some View {
        Button(action: {
            self.isShowingDeleteAlert.toggle()
        }) {
            HStack {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                Text("刪除")
                    .foregroundColor(.red)
            }
        }
        .alert(isPresented: $isShowingDeleteAlert, content: { deleteAlert })
    }
    
    private var deleteAlert: Alert {
        let alert = Alert(
            title: Text("刪除"),
            message: Text("確定要刪除嗎？"),
            primaryButton: .destructive(Text("確定")) {
                print("確定")
            },
            secondaryButton: .cancel(Text("取消")) {
                
            }
        )
        
        return alert
    }
}

#Preview {
    SwiftUIAlert()
}
