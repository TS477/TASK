//
//  NodeModel.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct NoteModel: Identifiable {
    var id: UUID = UUID()
    var text: String
}

var NoteModels: [NoteModel] = [
    NoteModel(text: "你好啊"),
    NoteModel(text: "不好")
]
