//
//  EventCommentModel.swift
//  TASK
//
//  Created by TSOvO on 19/10/2025.
//

struct EventCommentModel: Codable, Identifiable {
    let id: Int
    let userIconUrl: String
    let comment: String
    let createDate: String
    let createTime: String
    
    // 對應 JSON 的 key 命名
    enum CodingKeys: String, CodingKey {
        case id = "comment_id"
        case userIconUrl = "user_icon_url"
        case comment = "comment"
        case createDate = "create_date"
        case createTime = "create_time"
    }
}
