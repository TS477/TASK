//
//  SwiftUISettingButton.swift
//  Demo
//
//  Created by TSOvO on 27/8/2025.
//

import SwiftUI

struct SwiftUISettingButton: View {
    var buttonName: String = ""
    var buttonImage: String = ""
    
    var body: some View {
        HStack {
            HStack() {
                Image(systemName: buttonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                
                Text(buttonName)
                    .font(.system(size: 24))
            }

            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 14)
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: 70)
        .background(.white.opacity(0.85))
        .cornerRadius(20)
        .padding(.horizontal, 10)
    }
}

#Preview {
    SwiftUISettingButton(buttonName: "帳號設定", buttonImage: "person")
    SwiftUISettingButton(buttonName: "用戶設定" ,buttonImage: "person.slash")

}
