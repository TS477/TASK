//
//  SwiftUIContextMenu.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct SwiftUIContextMenu: View {
    @State var text: String = "世界很大，也很精彩"
    
    var body: some View {
        Text(text)
            .font(.system(size: 24))
            .padding()
            .background(
                .gray
                .opacity(0.2)
            )
            .cornerRadius(20)
            .contextMenu {
                Button("複製文字") {
                    UIPasteboard.general.string = text
                }
            }
    }
}

#Preview {
    SwiftUIContextMenu()
}
