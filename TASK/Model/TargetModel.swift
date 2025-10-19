//
//  TargetModel.swift
//  TASK
//
//  Created by TSOvO on 19/10/2025.
//

import Foundation

struct TargetModel: Codable, Identifiable {
    let id: UUID = UUID()
    let targetName: String
    let abilityVal1: Int
    let abilityVal2: Int
    let abilityVal3: Int
    let abilityVal4: Int
    let abilityVal5: Int
    let abilityVal6: Int
    let abilityVal7: Int
    let abilityVal8: Int
    let abilityVal9: Int
    let customVal: Int
    let systemImageName: String
    
    // 對應 JSON 的 key 命名
    enum CodingKeys: String, CodingKey {
        case targetName = "target_name"
        case abilityVal1 = "ability1"
        case abilityVal2 = "ability2"
        case abilityVal3 = "ability3"
        case abilityVal4 = "ability4"
        case abilityVal5 = "ability5"
        case abilityVal6 = "ability6"
        case abilityVal7 = "ability7"
        case abilityVal8 = "ability8"
        case abilityVal9 = "ability9"
        case customVal = "custom_val"
        case systemImageName = "system_image_name"
        
    }
}
