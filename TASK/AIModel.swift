//
//  AIModel.swift
//  Demo
//
//  Created by TSOvO on 29/8/2025.
//

import OpenAI

class AIModel {
    static private var openai: OpenAI = OpenAI(
        configuration: OpenAI.Configuration(
            token: "sk-xfRgQHjLppotD50TBe311a0b9a774f9e993a54BcEfC986Ae",
            host: "free.v36.cm"
        )
    )
     
    static public func sendMessage(question: String, completion: @escaping (String) -> Void) {
        Task {
            do {
                let query = ChatQuery(
                    messages: [ // 信息設置，例如角色，創新度等等
                        .user(.init(content: .string(question)))
                    ],
                    model: "gpt-4o-mini" // 用的模型，這裡是gpt 4o mini
                )
                
                let result = try await openai.chats(query: query)
                
                await MainActor.run { // 這個是協程，等待服務器的ai回應
                    if let content = result.choices.first?.message.content {
                        completion(content)
                    }
                }
                
            } catch {
                await MainActor.run {
                    var errorResponseText: String = "错误: \(error.localizedDescription)"
                    completion(errorResponseText)
                }
            }
        }
    }
}
