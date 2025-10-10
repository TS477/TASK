//
//  UserViewModel.swift
//  TASK
//
//  Created by TSOvO on 10/9/2025.
//

import SwiftUI
import CryptoKit

class UserViewModel: ObservableObject {
    private let userService: UserService
    
    let mainUrl: String = "https://task.aifabula784.workers.dev"
    let iconUrl: String = "/student/icon/"
    
    // 計算屬性，從服務層獲取數據
    var id: Int { userService.currentUser.id }
    var name: String { userService.currentUser.name }
    var imageUrl: String { userService.currentUser.iconUrl }
    var schoolName: String { userService.currentUser.schoolName }
    var age: Int { userService.currentUser.age }
    
    var abilityVal1: Int { userService.currentUser.abilityVal1 }
    var abilityVal2: Int { userService.currentUser.abilityVal2 }
    var abilityVal3: Int { userService.currentUser.abilityVal3 }
    var abilityVal4: Int { userService.currentUser.abilityVal4 }
    var abilityVal5: Int { userService.currentUser.abilityVal5 }
    var abilityVal6: Int { userService.currentUser.abilityVal6 }
    var abilityVal7: Int { userService.currentUser.abilityVal7 }
    var abilityVal8: Int { userService.currentUser.abilityVal8 }
    var abilityValCustomized: Int { userService.currentUser.abilityValCustomized }
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    // 登入功能
    func fetchUser(userId: Int, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        var components = URLComponents(string: "\(self.mainUrl)/student")
        
        let encryptedPassword: String = sha256Hash(password)
        components?.queryItems = [
            URLQueryItem(name: "id", value: "\(userId)"),
            URLQueryItem(name: "password", value: "\(encryptedPassword)")
        ]
        
        guard let url = components?.url else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
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
                // 更新服務層的用戶資料
                self.userService.updateUser(user)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // 登出功能
    func deleteUser() {
        userService.clearUser()
    }
    
    private func sha256Hash(_ string: String) -> String {
        let inputData = Data(string.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }
}
