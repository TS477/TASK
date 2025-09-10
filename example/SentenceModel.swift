//
//  SentenceModel.swift
//  Demo
//
//  Created by TSOvO on 27/8/2025.
//

import SwiftUI

struct SentenceModel: Identifiable {
    var id: UUID = UUID()
    var text: String
    var image: String
}

var sentenceModels: [SentenceModel] = [
    SentenceModel(text: "iSupr8", image: "icon_iSupr8"),
    
    SentenceModel(text: "Vintage Deco (IPhone)", image: "icon_vintage_deco"),
    
    SentenceModel(text: "Ricco2 (iPhone/iPad)", image: "icon_ricco2"),
    
    SentenceModel(text: "Snapeee", image: "icon_snapeee")
]
