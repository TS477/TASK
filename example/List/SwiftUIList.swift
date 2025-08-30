//
//  SwiftUIList.swift
//  Demo
//
//  Created by TSOvO on 27/8/2025.
//

import SwiftUI

struct SwiftUIList: View {
    @State var sentences: [SentenceModel] = sentenceModels
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.gray
                    .opacity(0.3)
                    .ignoresSafeArea()
                
                List() {
                    ForEach(sentences) { item in
                        ListItem(image: item.image, text: item.text)
                    }
                    .onMove(perform: moveItem)
                    .onDelete(perform: deleteItem)
                    .listRowSeparator(Visibility.hidden)
                    .listRowBackground(Color.white)
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("應用程序大全", displayMode: .inline)
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
    
    func moveItem(from source: IndexSet, to dest: Int) {
        sentences.move(fromOffsets: source, toOffset: dest)
    }
    
    func deleteItem(at offsets: IndexSet) {
        sentences.remove(atOffsets: offsets)
    }
}

struct ListItem: View {
    var image: String
    var text: String
    
    var body: some View {
        HStack(spacing: 30) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .clipShape(.circle)
                .overlay(
                    Circle()
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 2))
                )
            
            Text(text)
                .font(.system(size: 22))
                .bold()
        }
        .padding(.all, 4)
    }
}



#Preview {
    SwiftUIList()
}
