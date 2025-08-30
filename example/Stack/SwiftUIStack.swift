//
//  SwiftUIStack.swift
//  Demo
//
//  Created by TSOvO on 26/8/2025.
//

import SwiftUI

struct SwiftUIStack: View {
    var body: some View {
        ZStack {
            // background
            Image("StartUpImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x: 0, y: 0)
                .edgesIgnoringSafeArea(.all)
            
            
            
            VStack {
                Spacer()
                
                HStack(alignment: .center, spacing: 30) {
                    Image("ApplicationIcon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(12)
                        .background(.white)
                        .cornerRadius(20)
                    
                    Text("AIfabula")
                        .font(.system(size: 42))
                        .bold()
                        .foregroundColor(.white)
                }
            }
            }
        }
    }


#Preview {
    SwiftUIStack()
}
