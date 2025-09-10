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
    
    // 數據管理類
    class EventManager: ObservableObject {
        @Published var eventDatas: [EventData] = [
            EventData(
                proposer: "大大大老師",
                postImage: Image("StartUpImage"),
                eventName: "探老活動",
                date: Date(),
                description: "這是一個探望老人的活動",
                isLiked: false
            ),
            EventData(
                proposer: "陳大文主任",
                postImage: Image("DemoImage2"),
                eventName: "賣棋活動",
                date: Date(),
                description: "這是一個買旗活動",
                isLiked: false
            )
        ]
    }
    
    let eventManager: EventManager = EventManager()
    // test ////////////////////////

    @EnvironmentObject var buttomNavigation: Navigation
    // @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                // 背景
                Color(UIColor.systemBackground)
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                // 整體
                VStack() {
                    userAndGroupButton // 用戶和群
                    
                    // post
                    TabView {
                        ForEach(eventManager.eventDatas) { event in
                            EventView(eventData: event)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 500)
                    
                    Spacer()
                }
                .navigationBarTitle("才庫", displayMode: .large)
                .navigationBarItems(trailing: rightTopbutton)
            }
        }
        .navigationViewStyle(.stack)
        .onAppear() {
            print("hi")
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
        HStack(spacing:30) {
            let imageSize: CGFloat = 90
        
            // group components
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    // user button
                    Button(action: {
                        buttomNavigation.changeView(AnyView(MenuView()), needButtomNavigation: true)
                    }) {
                        Image("DemoImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageSize)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(lineWidth: 4)
                                    .fill(
                                        Gradient(colors: [.red, .blue])
                                    )
                            )
                            .padding(.leading, 12)
                    }
                    
                    ForEach(0..<groupImage.count, id: \.self) { index in
                        GroupButton(groupImage: groupImage[index], imageSize: imageSize)
                    }
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 2)
            }
            
        }
        .padding(.vertical)

    }
    
    // 群按鈕
    private struct GroupButton: View {
        @EnvironmentObject var buttonNavigation: Navigation
        
        var groupImage: Image
        var imageSize: CGFloat
        
        var body: some View {
            Button(action: {
                self.buttonNavigation.changeView(AnyView(EventOption()), needButtomNavigation: true)
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
        }
    }

    // post畫面
    struct EventView: View, Identifiable {
        var id: UUID = UUID()
        @ObservedObject var eventData: EventData
        
        @State var isDescriptionSheetPresented: Bool = false // 描述用
        
        var body: some View {
            VStack(alignment: .leading, spacing:20) {
                // 發起人
                HStack () {
                    let fontSize: CGFloat = 20
                    
                    
                    Text("發起人:")
                        .font(.system(size: fontSize))
                        .bold()
                        
                    Text(eventData.proposer)
                        .font(.system(size: fontSize))
                        
                }
                
                eventData.postImage
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 320)
                
                VStack(alignment: .leading, spacing: 4) {
                    let fontSize: CGFloat = 18
                    
                    // 點贊，評論，分享
                    HStack(spacing: 14) {
                        let imageSizeOffset: CGFloat = 12
                        
                        Button(action: {
                            eventData.toggleLike()
                        }) {
                            Image(systemName: eventData.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .font(.system(size: fontSize + imageSizeOffset))
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
                        
                        Text(eventData.eventName)
                            .font(.system(size: fontSize))
                            
                    }
                    
                    // 時間
                    HStack() {
                        Text("日期以及時間:")
                            .font(.system(size: fontSize))
                            .bold()
                        
                        Text("\(eventData.date.formatted())")
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
                        EventDesciptionSheetView(description: eventData.description)
                    }
  
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            // .background(Color.gray.opacity(0.15))
        }
    }
    
    // 用於創建post的數據
    class EventData: ObservableObject, Identifiable {
        let id: UUID = UUID()
        public var proposer: String
        public var postImage: Image
        public var eventName: String
        public var date: Date
        public var description: String
        @Published public var isLiked: Bool
        
        init(proposer: String, postImage: Image, eventName: String, date: Date, description: String, isLiked: Bool) {
            self.proposer = proposer
            self.postImage = postImage
            self.eventName = eventName
            self.date = date
            self.description = description
            self.isLiked = isLiked
        }
        
        func toggleLike() {
            self.isLiked = !self.isLiked
        }
    }
}




#Preview {
    HomePageView()
        .environmentObject(Navigation())
}
