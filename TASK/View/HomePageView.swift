//
//  MainView.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

// 首頁視圖
struct HomePageView: View {
    
    
    // test ///////////////////////
    let groupImage: [Image] = [
        Image("Monkey"),
        Image("Rabbit"),
        Image("Cat"),
    ]

    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var postViewModel: PostViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 背景
                Color(UIColor.systemBackground)
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                // 整體
                VStack() {
                    userAndGroupButton // 用戶和群
                    
                    TabView {
                        ForEach(postViewModel.posts) { post in
                            // like test //////////////////////////
                            EventView(postId: post.id, proposer: post.proposer, postImage: Image(""), eventName: post.eventName, date: post.date, description: post.description, isLiked: (post.isLike != 0),
                                likeCount: post.likeCount
                            )
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    // .frame(height: 500)
                    
                    Spacer()
                }
                .navigationBarItems(trailing: rightTopbutton)
                .navigationTitle(Text("才庫"))
            }
        }
        .navigationViewStyle(.stack)
        .onAppear() {
            Task {
                await postViewModel.loadMorePosts()
            }
        }
    }
    
    // 右上角的按鈕
    private var rightTopbutton: some View {
        HStack {
            let imageSize: CGFloat = 20
            
            Button(action: {
                // 通知操作
            }) {
                Image(systemName: "bell.fill")
                    .font(.system(size: imageSize))
                    .foregroundColor(
                        .orange
                    )
                
            }
            
            Button(action: {
                // 信息操作
            }) {
                Image(systemName: "ellipsis.message.fill")
                    .font(.system(size: imageSize))
                    .foregroundColor(.blue)
            }
        }
    }
    
    // 個人和群的部分
    private var userAndGroupButton: some View {
        HStack(spacing:10) {
            let imageSize: CGFloat = 90
        
            // group components
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    // user button
                    AsyncImage(url: URL(string: "\(userViewModel.mainUrl + userViewModel.iconUrl + String(userViewModel.id)).png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        // 加載中的佔位符
                        ProgressView()
                    }
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 4)
                            .fill(
                                Gradient(colors: [.red, .blue])
                            )
                    )
                    .padding(.leading, 12)
                    
                    ForEach(0..<groupImage.count, id: \.self) { index in
                        GroupButton(groupImage: groupImage[index], imageSize: imageSize)
                    }
                }
                // 頭像padding
                .padding(.vertical, 2)
                .padding(.horizontal, 2)
            }
            
        }
    }
    
    // 群按鈕
    private struct GroupButton: View {
        enum groupMenuItem: String, CaseIterable, Identifiable, Hashable {
            case eventOption = "群組選項"
            case AIChat = "AIChat"
            
            var id: String { rawValue }
        }
        
        @ViewBuilder
        private func groupDestinationView(for item: groupMenuItem) -> some View {
            switch item {
            case .eventOption:
                EventOption()
            case .AIChat:
                AIChatView()
            }
        }
        
        @State private var groupNavigationPath = NavigationPath()
        
        var groupImage: Image
        var imageSize: CGFloat
        
        var body: some View {
            // test ////////////////////////////
            NavigationStack(path: $groupNavigationPath) {
                Button(action: {
                    groupNavigationPath.append(groupMenuItem.eventOption)
                }) {
                    groupImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(lineWidth: 4)
                        )
                }
                .navigationDestination(for: groupMenuItem.self) { item in
                    groupDestinationView(for: item)
                }
            }
        }
    }

    // post畫面
    struct EventView: View, Identifiable {
        @EnvironmentObject var postViewModel: PostViewModel
        
        var id: UUID = UUID()
        @State var isDescriptionSheetPresented: Bool = false // 描述用
        
        var postId: Int
        var proposer: String
        var postImage: Image
        var eventName: String
        var date: String
        var description: String
        @State var isLiked: Bool
        @State var likeCount: Int
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                // 發起人
                HStack () {
                    let fontSize: CGFloat = 24
                    
                    
                    Text("發起人:")
                        .font(.system(size: fontSize))
                        .bold()
                        
                    Text(self.proposer)
                        .font(.system(size: fontSize))
                        
                }
                
                AsyncImage(url: URL(string: "\(PostViewModel.POSTER_URL + "/" + String(self.postId)).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                } placeholder: {
                    // 加載中的佔位符
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 4) {
                    let fontSize: CGFloat = 24
                    
                    // 點贊，評論，分享
                    HStack(spacing: 14) {
                        let imageSizeOffset: CGFloat = 12
                        
                        HStack(spacing: 4) {
                            
                            Button(action: {
                                if (self.isLiked) {
                                    likeCount -= 1
                                }
                                else {
                                    likeCount += 1
                                }
                                
                                self.isLiked.toggle()
                                postViewModel.toggleLike(eventId: self.postId)
                            }) {
                                Image(systemName: self.isLiked ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                                    .font(.system(size: fontSize + imageSizeOffset))
                            }
                            
                            Text(String(self.likeCount))
                                .font(.system(size: fontSize))
                        }
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "text.bubble")
                                .font(.system(size: fontSize + imageSizeOffset))
                        }
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundStyle(.gray)
                                .font(.system(size: fontSize + imageSizeOffset))
                        }
                        .padding(.vertical, 4)
                    }
                    
                    // 活動
                    HStack {
                        Text("活動名稱:")
                            .font(.system(size: fontSize))
                            .bold()
                        
                        Text(self.eventName)
                            .font(.system(size: fontSize))
                            
                    }
                    
                    // 時間
                    HStack() {
                        Text("日期以及時間:")
                            .font(.system(size: fontSize))
                            .bold()
                        
                        Text("\(self.date)")
                            .font(.system(size: fontSize))
                    }
                    
                    // 活動描述
                    Button(action: {
                        self.isDescriptionSheetPresented.toggle()
                    }){
                        Text("查看活動描述")
                            .font(.system(size: fontSize))
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $isDescriptionSheetPresented) {
                        EventDesciptionSheetView(description: self.description)
                    }
  
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            // .background(Color.gray.opacity(0.15))
        }
    }
}




#Preview {
    @Previewable @StateObject var userService = UserService()
    
    // 創建 ViewModel，注入同一個服務層實例
    var userViewModel: UserViewModel {
        UserViewModel(userService: userService)
    }
    
    var postViewModel: PostViewModel {
        PostViewModel(userService: userService)
    }
    
    MainView()
        .environmentObject(userViewModel)
        .environmentObject(postViewModel)
        .environmentObject(userService)
}
