//
//  IndexView.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct IndexView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                Spacer()
                
                Image("HeadShot")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(.circle)
                    .overlay(
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 4))
                    )
                
                
                // personal information
                VStack(spacing: 4) {
                    let fontSize: CGFloat = 20
                    
                    HStack {
                        Text("用戶名稱:")
                            .font(.system(size: fontSize))
                            .bold()
                        
                        Text("TSOvO")
                            .font(.system(size: fontSize))
                            .bold()
                            .foregroundColor(.red)
                    }
                    
                    Text("VIP高級會員")
                        .font(.system(size: fontSize-2))
                        .foregroundStyle(
                            .orange
                        )
                }
                
                VStack {
                    Text("簡歷")
                        .font(.system(size: 28, weight: .bold))
                        .padding(4)
                    
                    Text("從2005年開始便已經加入了apple Developer Program，並且從2019年開始持續更新此應用程式。除了讓自己在Apple Developer Program上更了解SwiftUI，還能用它來實踐自己想學的🎯")
                        .font(.system(size: 20))
                        .padding(.horizontal)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }.navigationBarTitle("首頁", displayMode: .inline)
        }
    }
}

#Preview {
    IndexView()
}
