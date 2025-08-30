//
//  LoginView.swift
//  Demo
//
//  Created by TSOvO on 27/8/2025.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            Color.red
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // login
                Spacer()
                Spacer()
                Spacer()
                
                VStack(spacing: 10) {
                    Image("LockImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    
                    Text("請登入")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                    
                    VStack(spacing: -10) {
                        TextField("帳號", text: $username)
                            .font(.system(size: 28))
                            .padding()
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.default)
                            .textContentType(.username)
                            .autocorrectionDisabled(true)
                        
                        SecureField("密码", text: $password)
                            .font(.system(size: 28))
                            .padding()
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.default)
                            .textContentType(.password)
                        .autocorrectionDisabled(true)                }
                    
                    
                }
                .padding()
                .frame(width: 350, height: 450)
                .background(
                    Color.white
                        .opacity(0.85)
                        .cornerRadius(20)
                )
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                // search
                VStack {
                    Text("有什麼搜索的嗎？")
                        .font(.system(size: 28))
                    
                    TextField("搜索", text: $searchText)
                        .padding(.horizontal, 50)
                        .padding(10)
                        .background(.white)
                        .cornerRadius(50)
                        .font(.system(size: 32))
                        .overlay(
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 28))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(18)
                        )
                        .padding(.horizontal ,30)
                }
                
            }
            
            
        }
        .onTapGesture {
            hideKeyBoard()
        }
    }
}

#Preview {
    LoginView()
}
