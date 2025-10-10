//
//  MenuView.swift
//  TASK
//
//  Created by TSOvO on 1/9/2025.
//

import SwiftUI

enum MenuItem: String, CaseIterable, Identifiable, Hashable {
    // menu
    case profile = "個人檔案"
    case target = "訂立目標"
    case record = "活動紀錄"
    case shop = "商店"
    case scanner = "掃瞄器"
    case settings = "設定"
    case logout = "登出"
    
    var id: String { rawValue }
}



struct MenuView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var navigationPath = NavigationPath()
    
    @Binding var isLoggedIn: Bool
    
    @ViewBuilder
    private func destinationView(for item: MenuItem) -> some View {
        switch item {
            // menu
        case .profile:
            ProfileView()
        case .target:
            TargetSelectionView()
        case .record:
            EventRecordView()
        case .shop:
            EmptyView()
        case .scanner:
            EmptyView()
        case .settings:
            EmptyView()
        case .logout:
            LoginView()
        }
    }
    
    var body: some View {
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
            
            /*
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
             */
            
            MenuButton(
                title: "登出",
                icon: "inset.filled.leadinghalf.arrow.leading.rectangle",
                color: .red,
                action: {
                    // 清空
                    navigationPath.removeLast(navigationPath.count)
                    isLoggedIn = false
                }
            )
        }
    }

}

struct MenuButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
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
    @Previewable @State var isLoggedIn: Bool = true
    @Previewable @StateObject var userService = UserService()
    
    // 創建 ViewModel，注入同一個服務層實例
    var userViewModel: UserViewModel {
        UserViewModel(userService: userService)
    }
    
    
    MenuView(isLoggedIn: $isLoggedIn)
        .environmentObject(userViewModel)
    
}
