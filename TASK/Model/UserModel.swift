//
//  UserModel.swift
//  TASK
//
//  Created by TSOvO on 10/9/2025.
//

import Foundation

struct UserModel: Codable, Identifiable {
    var id: Int = -1
    var name: String = ""
    var imageUrl: String = ""
    
    var abilityVal1: Int = 0
    var abilityVal2: Int = 0
    var abilityVal3: Int = 0
    var abilityVal4: Int = 0
    var abilityVal5: Int = 0
    var abilityVal6: Int = 0
    var abilityVal7: Int = 0
    var abilityVal8: Int = 0
}
