//
//  AccountSettingView.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct AccountSettingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarTitle(Text("用戶設定"), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: leftButton)
    
    }
    
    private var leftButton: some View {
        // back button
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("返回")
                    .font(.system(size: 21))
            }

        }
    }
}

#Preview {
    AccountSettingView()
}
