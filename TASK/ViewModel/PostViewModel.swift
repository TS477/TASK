//
//  PostViewModel.swift
//  TASK
//
//  Created by TSOvO on 20/9/2025.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published private(set) var posts: [PostModel] = []
    private var currentPage = 0
    private let PAGE_SIZE = 5 // 每次加載多少個個
    
    static let POSTER_URL: String = "https://task.aifabula784.workers.dev/post/poster/"
    
    init(posts: [PostModel]) {
        self.posts = posts
    }
    
    // 加載更多帖子
    func loadMorePosts() async {
        do {
            // 獲取新的帖子
            let newPosts = try await fetchPosts()
        
            // 將新帖子添加到現有數組中
            posts.append(contentsOf: newPosts)
            
            // 頁數增加，為下一次加載做準備
            currentPage += 1
            
            print("加載了 \(newPosts.count) 個新帖子，當前總數: \(posts.count)")
            
        } catch {
            print("加載帖子失敗: \(error)")
        }
    }
    
    // 重置加載狀態（如果需要重新加載）
    func resetLoading() {
        currentPage = 0
        posts.removeAll()
    }
    
    // 實際的網絡請求函數
    private func fetchPosts() async throws -> [PostModel] {
        do {
            // 構建 URL - 這裡需要替換為您的實際 API 端點
            
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd" // 設置你想要的格式
            let formattedDate = formatter.string(from: currentDate)

            
            // 沒加日期 //////////////////////////////////////////////////
            let urlString = "https://task.aifabula784.workers.dev/post?pageSize=\(PAGE_SIZE)&currentPage=\(currentPage)&currentDate=\(formattedDate)"
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            // 發起網絡請求
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // 解碼 JSON 數據
            let decoder = JSONDecoder()
            let posts = try decoder.decode([PostModel].self, from: data)
            
            return posts
        }
        catch {
            print("不加載任何活動帖子")
            return []
        }
        

    }
}
