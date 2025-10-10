//
//  PostModel.swift
//  TASK
//
//  Created by TSOvO on 20/9/2025.
//

import Foundation

struct PostModel: Codable, Identifiable {
    let id: Int
    let eventName: String
    let abilityVal1: Int
    let abilityVal2: Int
    let abilityVal3: Int
    let abilityVal4: Int
    let abilityVal5: Int
    let abilityVal6: Int
    let abilityVal7: Int
    let abilityVal8: Int
    let description: String
    let date: String
    let postUrl: String
    let proposer: String
    let isLike: Int
    let likeCount: Int
    
    // 對應 JSON 的 key 命名
    enum CodingKeys: String, CodingKey {
        case id = "event_id"
        case eventName = "event_name"
        case abilityVal1 = "ability1"
        case abilityVal2 = "ability2"
        case abilityVal3 = "ability3"
        case abilityVal4 = "ability4"
        case abilityVal5 = "ability5"
        case abilityVal6 = "ability6"
        case abilityVal7 = "ability7"
        case abilityVal8 = "ability8"
        case description
        case date
        case postUrl = "post_url"
        case proposer
        case isLike = "is_like"
        case likeCount = "like_count"
    }
}
