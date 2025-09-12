//
//  AppLoginView.swift
//  TASK
//
//  Created by TSOvO on 10/9/2025.
//

import SwiftUI


struct AppLoginView: View {
    @EnvironmentObject var navigation: Navigation
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var showForgotPassword: Bool = false
    @State private var isFailedLogin: Bool = false
    
    var body: some View {
        ZStack {
            // 背景 - 柔和的渐变
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.95, green: 0.97, blue: 1.0),
                                                       Color(red: 0.88, green: 0.94, blue: 1.0)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // 标题区域
                VStack(spacing: 15) {
                    Image(systemName: "book.closed.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.white)
                                .shadow(color: .blue.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                    
                    Text("TASK")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                    
                    Text("歡迎你回來")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)
                
                // 表单区域
                VStack(spacing: 20) {
                    // 用户名输入框
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        
                        TextField("用户名/邮箱", text: $username)
                            .font(.system(size: 20, design: .rounded))
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: .blue.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    
                    // 密码输入框
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        
                        SecureField("密码", text: $password)
                            .font(.system(size: 20, design: .rounded))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: .blue.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    
                    // 记住我和忘记密码
                    HStack {
                        Toggle(isOn: $rememberMe) {
                            Text("记住我")
                                .font(.system(size: 18, design: .rounded))
                                .foregroundColor(.gray)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        Spacer()
                        
                        Button(action: {
                            showForgotPassword.toggle()
                        }) {
                            Text("忘记密码?")
                                .font(.system(size: 18, design: .rounded))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 5)
                }
                .padding(.horizontal, 40)
                
                // 登录按钮
                Button(action: {
                    // 处理登录逻辑
                    login()
                }) {
                    Text("登录")
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                     startPoint: .leading,
                                                     endPoint: .trailing))
                        )
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)
                
                if (self.isFailedLogin) {
                    Text("用戶ID或者密碼錯誤")
                        .font(.system(size: 20))
                        .foregroundStyle(.red)
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $showForgotPassword) {
            ForgotPasswordView()
        }
        .onAppear() { // 每次進入這個畫面都要重置用戶
            userViewModel.deleteUser()
        }
    }
    
    private func login() {
        userViewModel.fetchUser(userId: Int(username) ?? -1, password: self.password) { result in
            switch result {
            case .success(_):
                print("用戶登錄成功")
                
                navigation.changeView(AnyView(HomePageView()), needButtomNavigation: true)
                
            case .failure(let error):
                print("获取用户失败: \(error)")
                
                self.isFailedLogin = true
            }
        }
    }
}

// 自定义复选框样式
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                configuration.label
            }
        }
    }
}

// 忘记密码视图
struct ForgotPasswordView: View {
    @State private var email: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                
                Text("重置密码")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                
                Text("请输入你的邮箱地址，我们将发送密码重置链接")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                TextField("邮箱地址", text: $email)
                    .font(.system(size: 20, design: .rounded))
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                    .padding(.horizontal, 40)
                
                Button(action: {
                    // 处理重置密码逻辑
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("发送重置链接")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing))
                        )
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding(.top, 40)
            .navigationBarTitle("忘记密码", displayMode: .inline)
            .navigationBarItems(trailing: Button("取消") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview() {
    AppLoginView()
        .environmentObject(Navigation())
        .environmentObject(UserViewModel(userModel: UserModel()))
}
