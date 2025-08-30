//
//  FoodListView.swift
//  Foodpicker
//
//  Created by CHEUNG Ka Tsun on 30/8/2025.
//
import SwiftUI

struct FoodListView: View{
    @Environment(\.editMode) var editMode
    @State private var food = Food.example + Food.example
    @State private var selectedFood = Set<Food.ID>()
    var body : some View{
        VStack(alignment: .leading){
            titleBar
            List($food, editActions: .all,selection: $selectedFood){
                $food in Text(food.name)
            }.listStyle(.plain)
                .padding(.horizontal)
        }.background(Color.brown.opacity(0.1))
            .safeAreaInset(edge:.bottom,alignment: .trailing){
                    addButton
            }
    }
}
private extension FoodListView{
    var titleBar: some View {
        HStack{
            Label("Selected Foods", systemImage: "person.3")
                .font(.title.bold())
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            EditButton()
                .buttonStyle(.bordered)
        }
    }
    var addButton: some View {
        Button(){}label:{
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .background(.white, in:Circle())
                .padding()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white,Color.accentColor.gradient)
        }
    }
}
#Preview{
    FoodListView()
}
