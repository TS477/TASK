//
//  UserModel.swift
//  TASK
//
//  Created by TSOvO on 10/9/2025.
//

import Foundation

struct UserModel: Codable, Identifiable {
    var id: Int = -1
    var age: Int = -1
    var schoolName: String = "測試學校名字"
    var name: String = "測試名字"
    var iconUrl: String = "測試iconURL"
    
    var abilityVal1: Int = 0
    var abilityVal2: Int = 0
    var abilityVal3: Int = 0
    var abilityVal4: Int = 0
    var abilityVal5: Int = 0
    var abilityVal6: Int = 0
    var abilityVal7: Int = 0
    var abilityVal8: Int = 0
    var abilityValCustomized: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case age
        case schoolName = "school_name"
        case name
        case abilityVal1 = "ability_val1"
        case abilityVal2 = "ability_val2"
        case abilityVal3 = "ability_val3"
        case abilityVal4 = "ability_val4"
        case abilityVal5 = "ability_val5"
        case abilityVal6 = "ability_val6"
        case abilityVal7 = "ability_val7"
        case abilityVal8 = "ability_val8"
    }
}
