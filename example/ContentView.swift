//
//  ContentView.swift
//  Foodpicker
//
//  Created by CHEUNG Ka Tsun on 20/8/2025.
//

import SwiftUI
extension AnyTransition {
    static let delayInsertionOpacity = Self.asymmetric(insertion: .opacity, removal: .opacity)
        
}
struct ContentView: View {
    let lunchOptions = Food.example
    @State private var selectedFood: Food?
    @State private var showInfo: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 30) {
                foodImage

                selectedFoodInfoView
                Text("What to eat today?")
                    .font(.largeTitle)
                    .bold(true)
                foodDetailView
                bottomResetView
                Spacer().layoutPriority(1)
            }.padding()
                .frame(maxWidth: .infinity,maxHeight: UIScreen.main.bounds.height-100)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .animation(.spring,value: showInfo)
                .animation(.easeInOut(duration: 1),value:selectedFood)
        }.background(Color(.secondarySystemBackground))
    }
}
//MARK: -Subviews
private extension ContentView{
    //init(selectedFood: Food){
        //_selectedFood = State(wrappedValue: selectedFood)
        var foodImage: some View {
            Group {
                if selectedFood != nil {
                    HStack{
                        Text(selectedFood!.image)
                            .font(.system(size: 200))
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                            .border(Color.green)
                    }
                }else {
                    Image("dinner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }.frame(height: 250)
        }
        @ViewBuilder var selectedFoodInfoView: some View{
            if selectedFood != nil {
                HStack{
                    Text(selectedFood!.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                        .id(selectedFood!.name)
                    Button{
                        showInfo.toggle()
                    }
                    label:{
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.secondary)
                    }.buttonStyle(.plain)
                }
            }
        }
        var foodDetailView : some View {
            Button{
                selectedFood = lunchOptions.shuffled().first
            } label: {
                Text(selectedFood == nil ?"tell me!": "change").frame(width: 200, height: 50, alignment: .center)
                    .animation(.none,value: selectedFood)
                    .transformEffect(.identity)
            }.font(.title)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .buttonStyle(.bordered)
        }
        var bottomResetView: some View {
            Button{
                selectedFood = nil
            } label: {
                Text("reset!")
            }.font(.title)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
        }
    }
extension View{
    
}
#Preview{
    ContentView()
}
