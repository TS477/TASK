//
//  SwiftUIScrollView.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct SwiftUIScrollView: View {
    var imageName: [String] = [
        "Cat",
        "Pig",
        "Bear",
        "Monkey",
        "Rabbit",
    ]
    
    var body: some View {
        
        
        VStack {
            // horizontal
            HStack {
                Text("橫向移動")
                    .font(.system(size: 24))
                    .bold()
                    .padding()
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(imageName, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                    }
                }
            }
            .padding()
            
            // vertical
            HStack {
                Text("縱向移動")
                    .font(.system(size: 24))
                    .bold()
                    .padding()
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(imageName, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SwiftUIScrollView()
}
