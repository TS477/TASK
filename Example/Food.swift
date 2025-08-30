//
//  Food.swift
//  Foodpicker
//
//  Created by CHEUNG Ka Tsun on 27/8/2025.
//
import Foundation
struct Food : Equatable,Identifiable {
    let id = UUID()
    var name: String
    var image: String
    var calories: Int
    var carb: Double
    var fat: Double
    var protein: Double
    
    static let example = [
            Food(name: "蘋果", image: "🍎", calories: 52, carb: 14.0, fat: 0.2, protein: 0.3),
            Food(name: "雞胸肉", image: "🍗", calories: 165, carb: 0.0, fat: 3.6, protein: 31.0),
            Food(name: "鮭魚", image: "🐟", calories: 206, carb: 0.0, fat: 13.0, protein: 22.0),
            Food(name: "白米飯", image: "🍚", calories: 130, carb: 28.0, fat: 0.3, protein: 2.7),
            Food(name: "酪梨", image: "🥑", calories: 160, carb: 9.0, fat: 15.0, protein: 2.0),
            Food(name: "希臘優格", image: "🥣", calories: 59, carb: 3.6, fat: 0.4, protein: 10.0),
            Food(name: "全麥麵包", image: "🍞", calories: 79, carb: 13.0, fat: 1.0, protein: 4.0),
            Food(name: "雞蛋", image: "🥚", calories: 68, carb: 0.6, fat: 4.8, protein: 5.5)
    ]
}
