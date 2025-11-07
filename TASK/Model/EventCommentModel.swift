//
//  EventCommentModel.swift
//  TASK
//
//  Created by TSOvO on 19/10/2025.
//

struct EventCommentModel: Codable, Identifiable {
    let id: Int
    let userIconUrl: String
    let commentText: String
    
    // 對應 JSON 的 key 命名
    enum CodingKeys: String, CodingKey {
        case id = "comment_id"
        case userIconUrl = "icon_url"
        case commentText = "comment_text"
    }
}
