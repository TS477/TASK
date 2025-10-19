//
//  PostViewModel.swift
//  TASK
//
//  Created by TSOvO on 20/9/2025.
//
import Foundation

class PostViewModel: ObservableObject {
    @Published private(set) var posts: [PostModel] = []
    private let userService: UserService
    private var currentPage = 0
    private let PAGE_SIZE = 5
    
    static let POSTER_URL: String = "https://task.aifabula784.workers.dev/post/poster"
    static let POST_URL: String = "https://task.aifabula784.workers.dev/post"
    
    // 計算屬性，從服務層獲取當前用戶
    var currentUser: UserModel {
        userService.currentUser
    }
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    // 加載更多帖子
    func loadMorePosts() async {
        do {
            let newPosts = try await fetchPosts()
            posts.append(contentsOf: newPosts)
            currentPage += 1
            print("加載了 \(newPosts.count) 個新帖子，當前總數: \(posts.count)")
        } catch {
            print("加載帖子失敗: \(error)")
        }
    }
    
    // 重置加載狀態
    func resetLoading() {
        currentPage = 0
        posts.removeAll()
    }
    
    // 按讚
    func toggleLike(eventId: Int) {
        print("請求按讚")
        
        let url = URL(string: "\(PostViewModel.POST_URL)?userId=\(self.currentUser.id)&eventId=\(eventId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let result = try JSONDecoder().decode([String: Bool].self, from: data)
                print("点赞状态: \(result["liked"] ?? false)")
            } catch {
                print("按讚請求錯誤: \(error)")
            }
        }
    }
    
    // 實際的網絡請求函數
    private func fetchPosts() async throws -> [PostModel] {
        do {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = formatter.string(from: currentDate)
            
            let urlString = PostViewModel.POST_URL + "?pageSize=\(PAGE_SIZE)&currentPage=\(currentPage)&currentDate=\(formattedDate)&id=\(self.currentUser.id)"
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let posts = try decoder.decode([PostModel].self, from: data)
            
            return posts
        } catch {
            print(error)
            print("不加載任何活動帖子")
            return []
        }
    }
}
