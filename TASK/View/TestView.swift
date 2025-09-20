//
//  TestView.swift
//  Demo
//
//  Created by TSOvO on 29/8/2025.
//

import SwiftUI
import CryptoKit

struct TestView: View {
    @EnvironmentObject var postViewModel: PostViewModel
    
    var body: some View {
     
        VStack {
            
        }
        .onAppear() {
            Task {
                await postViewModel.loadMorePosts()

            }
        }
    }
}



#Preview {
    TestView()
        .environmentObject(PostViewModel(posts: []))
}
