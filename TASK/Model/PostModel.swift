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
    let schoolId: Int
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
    let postUrl: String?
    let responseTeacherId: Int?
    
    // 對應 JSON 的 key 命名
    enum CodingKeys: String, CodingKey {
        case id
        case eventName = "event_name"
        case schoolId = "school_id"
        case abilityVal1 = "ability_val1"
        case abilityVal2 = "ability_val2"
        case abilityVal3 = "ability_val3"
        case abilityVal4 = "ability_val4"
        case abilityVal5 = "ability_val5"
        case abilityVal6 = "ability_val6"
        case abilityVal7 = "ability_val7"
        case abilityVal8 = "ability_val8"
        case description
        case date
        case postUrl = "post_url"
        case responseTeacherId = "response_teacher_id"
    }
}
