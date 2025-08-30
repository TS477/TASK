//
//  SwiftUIPoprover.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct SwiftUIPoprover: View {
    @State var notes: [NoteModel] = NoteModels
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    /*@START_MENU_TOKEN@*/Text(note.text)/*@END_MENU_TOKEN@*/
                }
            }
            .navigationBarTitle("筆記", displayMode: .inline)
            .navigationBarItems(trailing: newButton)
        }
        .fullScreenCover(isPresented: $isSheetPresented) {
            AddNoteView(notes: $notes)
        }
    
    }
    
    private var newButton: some View {
        Button(action: {
            self.isSheetPresented.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 20))
        }
    }
}




#Preview {
    SwiftUIPoprover()
}
