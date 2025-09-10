//
//  DisclosureGroupView.swift
//  Demo
//
//  Created by TSOvO on 30/8/2025.
//

import SwiftUI

struct DisclosureGroupView: View {
    var body: some View {
        DisclosureGroup("如何修改密碼?") {
            Text("進入右邊帳號設置，點擊修改密碼")
                .font(.system(size: 28))
        }
        .font(.system(size: 28))
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    DisclosureGroupView()
}
