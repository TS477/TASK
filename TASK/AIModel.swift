//
//  AIModel.swift
//  Demo
//
//  Created by TSOvO on 29/8/2025.
//

import Foundation

class AIModel {
    static private let aiURL = "https://task.aifabula784.workers.dev/ai"
    
    static public func sendMessage(question: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: aiURL) else {
            completion("錯誤: URL 無效")
            return
        }
        
        let body = ["question": question]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion("錯誤: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion("無回應") }
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let answer = json["answer"] as? String {
                DispatchQueue.main.async {
                    completion(answer)
                }
            } else if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let errorMsg = json["error"] as? String {
                DispatchQueue.main.async {
                    completion("AI 錯誤: \(errorMsg)")
                }
            } else {
                DispatchQueue.main.async {
                    completion("未知錯誤")
                }
            }
        }.resume()
    }
}
