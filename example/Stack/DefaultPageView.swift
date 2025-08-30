//
//  DefaultPageView.swift
//  Demo
//
//  Created by TSOvO on 26/8/2025.
//

import SwiftUI

struct DefaultPageView: View {
    var body: some View {
        ZStack {
            Color.orange.opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Image("DefaultImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                
                VStack(spacing: 8) {
                    Text("目前尚未收到任何消息")
                        .font(.system(size: 24))
                        .foregroundColor(.primary)
                        .bold()
                    
                    Text("你可以先去商城看看喔！")
                        .font(.system(size: 17))
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    DefaultPageView()
}
