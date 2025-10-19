//
//  MenuView.swift
//  TASK
//
//  Created by TSOvO on 1/9/2025.
//

import SwiftUI

struct MenuView: View {
    // test ///////////////////
    var personalImage: Image = Image("personal")
    // test ///////////////////
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
<<<<<<< HEAD
        ZStack {
            // 背景渐变
            /*
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
             */
=======
        NavigationStack(path: $navigationPath) {
            ZStack {
                // 背景渐变（可選）
                // LinearGradient(...)
                
                // 菜单容器
                VStack(spacing: 20) {
                    // 用戶頭像
                    userAvatar
                        .padding(10)
                    
                    // 菜单按钮
                    menuButtons
                    
                    Spacer()
                }
                .padding()
            }
            .navigationDestination(for: MenuItem.self) { item in
                destinationView(for: item)
            }
        }
    }
    
    private var userAvatar: some View {
        VStack {
            let iconSize: CGFloat = 110
            
            AsyncImage(url: URL(string: "\(userViewModel.mainUrl)\(userViewModel.iconUrl)\(userViewModel.id).png")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: iconSize, height: iconSize)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(lineWidth: 4)
                    .fill(
                        Gradient(colors: [.red, .blue])
                    )
            )
        }
        

    }
    
    private var menuButtons: some View {
        VStack(spacing: 16) {
            MenuButton(
                title: "個人檔案",
                icon: "person.circle.fill",
                color: .green,
                action: { navigationPath.append(MenuItem.profile) }
            )
            
            MenuButton(
                title: "訂立目標",
                icon: "target",
                color: .blue,
                action: { navigationPath.append(MenuItem.target) }
            )
            
            MenuButton(
                title: "活動紀錄",
                icon: "list.bullet.clipboard.fill",
                color: .orange,
                action: { navigationPath.append(MenuItem.record) }
            )
            
            MenuButton(
                title: "商店",
                icon: "cart.fill",
                color: .purple,
                action: { navigationPath.append(MenuItem.shop) }
            )
            
            MenuButton(
                title: "掃瞄器",
                icon: "qrcode.viewfinder",
                color: .indigo,
                action: { navigationPath.append(MenuItem.scanner) }
            )
            
            MenuButton(
                title: "設定",
                icon: "gearshape.fill",
                color: .gray,
                action: { navigationPath.append(MenuItem.settings) }
            )
>>>>>>> parent of a5825e9 (修改MainView)
            
            // 菜单容器
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: "\(userViewModel.mainUrl + userViewModel.iconUrl + String(userViewModel.id)).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    // 加載中的佔位符
                    ProgressView()
                }
                .frame(width: 110)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(lineWidth: 4)
                        .fill(
                            Gradient(colors: [.red, .blue])
                        )
                )
                .padding(10)
                /*
                personalImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 4)
                            .fill(
                                Gradient(colors: [.red, .blue])
                            )
                    )
                    .padding(10)
                 */
                
                // 菜单按钮
                MenuButton(title: "個人檔案", icon: "person.circle.fill", color: .green,
                           targetView: AnyView(ProfileView()))
                                
                MenuButton(title: "訂立目標", icon: "target", color: .blue,
                           targetView: AnyView(TargetSelectionView()),
                needButtomNavigation: true)
                                
                MenuButton(title: "活動紀錄", icon: "list.bullet.clipboard.fill", color: .orange,
                           targetView: AnyView(EventRecordView()))
                                
                MenuButton(title: "商店", icon: "cart.fill", color: .purple,
                           targetView: AnyView(EmptyView()))
                                
                MenuButton(title: "掃瞄器", icon: "qrcode.viewfinder", color: .indigo,
                           targetView: AnyView(EmptyView()))
                                
                MenuButton(title: "設定", icon: "gearshape.fill", color: .gray,
                           targetView: AnyView(EmptyView()))
                                
                MenuButton(title: "登出", icon: "rectangle.portrait.and.arrow.right", color: .red,
                           targetView: AnyView(AppLoginView()),
                needButtomNavigation: false)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct MenuButton: View {
    let title: String
    let icon: String
    let color: Color
    let targetView: AnyView
    
    var needButtomNavigation: Bool = true
    
    @EnvironmentObject var buttomNavigation: Navigation
    
    var body: some View {
        Button(action: {
            buttomNavigation.changeView(targetView, needButtomNavigation: self.needButtomNavigation)
        }) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding()
            .background(color)
            .cornerRadius(15)
            .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 5)
        }
    }
}


#Preview {
    MenuView()
        .environmentObject(Navigation())
        .environmentObject(UserViewModel(userModel: UserModel()))
    
}
