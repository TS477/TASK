//
//  SwiftUITextView.swift
//  Demo
//
//  Created by TSOvO on 26/8/2025.
//

import SwiftUI

struct SwiftUITextView: View {
    @State var textInput: String = ""
    @State var sucureTextInput: String = ""
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            Spacer()
            TextField("用戶輸入", text: $textInput)
                .textFieldStyle(.roundedBorder)
                .textContentType(.telephoneNumber)
                .keyboardType(.numberPad)
                .autocorrectionDisabled(true)
                .padding(.leading, 80)
                .focused($isFocused)
                
            Spacer()
            Spacer()
           
        }
        
    }
}

#Preview {
    SwiftUITextView()
}
