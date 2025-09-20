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
    var school_name: String = "測試學校名字"
    var name: String = "測試名字"
    var icon_url: String = "測試iconURL"
    
    var ability_val1: Int = 0
    var ability_val2: Int = 0
    var ability_val3: Int = 0
    var ability_val4: Int = 0
    var ability_val5: Int = 0
    var ability_val6: Int = 0
    var ability_val7: Int = 0
    var ability_val8: Int = 0
    var ability_val_customized: Int = 0
}
