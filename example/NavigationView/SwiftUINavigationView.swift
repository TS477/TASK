//
//  SwiftUINavigationView.swift
//  Demo
//
//  Created by TSOvO on 27/8/2025.
//

import SwiftUI

struct SwiftUINavigationView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("HomeImage")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.75)
                    .blur(radius: 2)
                
                VStack(spacing: 20) {
                    NavigationLink(destination: AccountSettingView()) {
                        SwiftUISettingButton(buttonName: "用戶設定" ,buttonImage: "person.circle")
                    }
                    
                    SwiftUISettingButton(buttonName: "偏好設定" ,buttonImage: "lock.circle")
                    
                    SwiftUISettingButton(buttonName: "搜索" ,buttonImage: "magnifyingglass.circle")
                    
                    SwiftUISettingButton(buttonName: "查看餘額" ,buttonImage: "dollarsign.circle")
                    
                    SwiftUISettingButton(buttonName: "關於我們" ,buttonImage: "questionmark.circle")
                                        
                    Spacer()
                    
                }
                .padding(.top, 40)
                .navigationBarTitle("首頁", displayMode: .inline)
                .navigationBarItems(leading: leftButton, trailing: rightButton)
            }


        }
    }
    
    private var leftButton: some View {
        // back button
        Button(action: {
            
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("返回")
                    .font(.system(size: 21))
            }

        }
    }
    
    private var rightButton: some View {
        HStack {
            // search button
            Button(action: {
                
            }) {
                Image(systemName: "magnifyingglass")
            }
            
            // share button
            Button(action: {
                
            }) {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
}

#Preview {
    SwiftUINavigationView()
}
