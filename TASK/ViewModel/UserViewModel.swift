//
//  UserViewModel.swift
//  TASK
//
//  Created by TSOvO on 10/9/2025.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published private var userModel: UserModel
    
    var id: Int { userModel.id }
    var name: String { userModel.name }
    var imageUrl: String { userModel.imageUrl }
    var abilityVal1: Int { userModel.abilityVal1 }
    var abilityVal2: Int { userModel.abilityVal2 }
    var abilityVal3: Int { userModel.abilityVal3 }
    var abilityVal4: Int { userModel.abilityVal4 }
    var abilityVal5: Int { userModel.abilityVal5 }
    var abilityVal6: Int { userModel.abilityVal6 }
    var abilityVal7: Int { userModel.abilityVal7 }
    var abilityVal8: Int { userModel.abilityVal8 }
    
    init(userModel: UserModel) {
        self.userModel = userModel
        
        // test ////////////////////////////
        fetchUser(userId: 12345) { result in
            switch result {
            case .success(let user):
                print("用戶數據已經更新")
                
                self.userModel = user
            case .failure(let error):
                print("获取用户失败: \(error)")
            }
        }
        
        func fetchUser(userId: Int, completion: @escaping (Result<UserModel, Error>) -> Void) {
            var components = URLComponents(string: "https://testbase.yyang9102.workers.dev/user")
            components?.queryItems = [URLQueryItem(name: "id", value: "\(userId)")]
            
            // 製作url
            guard let url = components?.url else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            // 指定http方法
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            // 等待和接受回應
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // 检查HTTP状态码
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        completion(.failure(URLError(.badServerResponse)))
                        return
                    }
                }
                
                guard let data = data else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                do {
                    let user = try JSONDecoder().decode(UserModel.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
}
