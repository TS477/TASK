//
//  UserViewModel.swift
//  TASK
//
//  Created by TSOvO on 10/9/2025.
//

import SwiftUI
import CryptoKit

class UserViewModel: ObservableObject {
    @Published private var userModel: UserModel
    
    let mainUrl: String = "https://task.aifabula784.workers.dev"
    let iconUrl: String = "/student/icon/"
    
    var id: Int { userModel.id }
    var name: String { userModel.name }
    var imageUrl: String { userModel.icon_url }
    var schoolName: String { userModel.school_name }
    var age: Int { userModel.age }
    
    var abilityVal1: Int { userModel.ability_val1 }
    var abilityVal2: Int { userModel.ability_val2 }
    var abilityVal3: Int { userModel.ability_val3 }
    var abilityVal4: Int { userModel.ability_val4 }
    var abilityVal5: Int { userModel.ability_val5 }
    var abilityVal6: Int { userModel.ability_val6 }
    var abilityVal7: Int { userModel.ability_val7 }
    var abilityVal8: Int { userModel.ability_val8 }
    var abilityValCustomaized: Int { userModel.ability_val_customized }
    
    init(userModel: UserModel) {
        self.userModel = userModel
    }
    
    // test ///////////////////////////
    // 密碼要加鹽，還有一堆注入安全等等，先測試
    func fetchUser(userId: Int, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        var components = URLComponents(string: "\(self.mainUrl)/student")
        
        let encryptedPassword: String = sha256Hash(password) // 加密密碼
        components?.queryItems = [
            URLQueryItem(name: "id", value: "\(userId)"),
            URLQueryItem(name: "password", value: "\(encryptedPassword)")
        ] // 增加id, password參數
        
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
                self.userModel = user
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func deleteUser() {
        self.userModel = UserModel()
    }
    
    private func sha256Hash(_ string: String) -> String {
        let inputData = Data(string.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }
}
