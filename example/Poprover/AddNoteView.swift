//
//  AddNoteView.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct AddNoteView: View {
    @State var noteText: String = ""
    @Binding var notes: [NoteModel]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(
                    "輸入你的筆記",
                    text: $noteText
                )
                .keyboardType(.default)
                .textFieldStyle(.roundedBorder)
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("新增筆記", displayMode: .inline)
            .navigationBarItems(leading: backButton, trailing: saveButton)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
        }
    }

    private var saveButton: some View {
        Button(action: {
            if !noteText.isEmpty {
                self.notes.append(NoteModel(
                    text: self.noteText))
                
                print(noteText)
                
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
           Text("save")
                .font(.system(size: 20))
        }
    }
}



#Preview {
    AddNoteView(notes: .constant([]))
}
