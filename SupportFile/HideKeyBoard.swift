//
//  HideKeyBoard.swift
//  Demo
//
//  Created by TSOvO on 27/8/2025.
//

import SwiftUI


extension View {
    func hideKeyBoard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil)
        
    }
}
