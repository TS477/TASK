//
//  StatePageView.swift
//  Demo
//
//  Created by TSOvO on 26/8/2025.
//

import SwiftUI

struct StatePageView: View {
    var body: some View {
        ZStack {
            Color.orange
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                Image("GiftImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240)
                
                VStack(spacing: 42) {
                    VStack(spacing: 18) {
                        Text("簽到成功！")
                            .foregroundStyle(.primary)
                            .font(.title)
                            .bold()
                        
                        Text("再堅持兩天就可以得到400積分了!")
                            .foregroundStyle(.secondary)
                    }
                    
                    Text("知道了")
                        .font(.system(size: 24))
                        .bold()
                        .padding()
                        .frame(width: 200)
                        .background(.red)
                        .cornerRadius(32)                }
                
            }
            .padding()
            .frame(maxWidth: 320)
            .background(Color.white)
            .cornerRadius(32)
        
                
            
        }
    }
}

#Preview {
    StatePageView()
}
