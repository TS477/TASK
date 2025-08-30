//
//  SwiftUIImage.swift
//  Demo
//
//  Created by TSOvO on 25/8/2025.
//

import SwiftUI

struct SwiftUIImage: View {
    let url: String = "https://shorthand.com/the-craft/raster-images/assets/5kVrMqC0wp/sh-unsplash_5qt09yibrok-4096x2731.jpeg"
    
    var body: some View {
        VStack {
            ZStack {
                Image("DemoImage2")
                    .resizable()
                    .scaledToFit()
                    .frame(width:400)
                    .cornerRadius(30)
                    .clipShape(.circle)
                    .opacity(0.5)
                
                Image("DemoImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300)
                    .cornerRadius(30)
                    .clipShape(.circle)
                    .blendMode(.colorBurn)
                
                
                Text("上帝的聆聽")
                    .font(.system(size: 38))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
            }
            
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: 100))
                .foregroundColor(.blue)
                .padding(20)
                .background(Color(.systemGray5))
                .clipShape(.circle)
            
            AsyncImage(url: URL(string: url)) {image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 300)
                    
            } placeholder: {
                Text("加载中...")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding()
                    .frame(width: 450, height: 300)
                    .background(Color(.systemGray5))
            }
        }
    }
}

#Preview {
    SwiftUIImage()
}
