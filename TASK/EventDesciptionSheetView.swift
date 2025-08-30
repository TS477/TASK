//
//  EventDesciptionSheetView.swift
//  Demo
//
//  Created by TSOvO on 29/8/2025.
//

import SwiftUI

struct EventDesciptionSheetView: View {
    @Environment (\.presentationMode) var presentationMode
    
    var description: String
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(description)
                    .font(.system(size: 24))
                Spacer()
            }
            .padding()
            .navigationBarTitle("活動描述", displayMode: .large)
            .navigationBarItems(leading: backButton)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("返回")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(.red)
        }
    }
}

#Preview {
    EventDesciptionSheetView(description: "世界上最棒的活動，請不要錯過，請不要錯過，請不要錯過，請不要錯過，請不要錯過，請不要錯過")
}
