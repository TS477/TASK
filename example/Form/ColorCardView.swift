//
//  ColorCardView.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct ColorCardView: View {
    @State var redValue: CGFloat = 0
    @State var greenValue: CGFloat = 0
    @State var blueValue: CGFloat = 0
    @State var color: Color = .black
    
    var body: some View {
        Form {
            Section(
                header: Text("顏色預覽")
            ) {
                Rectangle()
                    .fill(Color(
                        red: redValue / 255,
                        green: greenValue / 255,
                        blue: blueValue / 255
                    ))
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .cornerRadius(20)
                    .padding(.vertical, 14)
            }
            
            
            Section(
                header: Text("紅色")
            ) {
                HStack {
                    Image(systemName: "r.circle")
                        .font(.system(size: 24))
                        .offset(x: -4)
                    
                    Text("\(Int(self.redValue))")
                        .font(.system(size: 18))
                        
                    Slider(value: $redValue, in: 0...255)
                        .accentColor(.red)
                }
            }
            
            Section(
                header: Text("綠色")
            ) {
                HStack {
                    Image(systemName: "g.circle")
                        .font(.system(size: 24))
                        .offset(x: -4)
                    
                    Text("\(Int(self.greenValue))")
                        .font(.system(size: 18))
                    
                    Slider(value: $greenValue, in: 0...255)
                        .accentColor(.green)
                }
            }
            
            Section(
                header: Text("藍色")
            ) {
                HStack {
                    Image(systemName: "b.circle")
                        .font(.system(size: 24))
                        .offset(x: -4)
                    
                    Text("\(Int(self.blueValue))")
                        .font(.system(size: 18))
                        
                    Slider(value: $blueValue, in: 0...255)
                        .accentColor(.blue)
                }
            }
            
            
            Section(
                header: Text("選擇顏色")
            ) {
                ColorPicker("選擇顏色", selection: $color)
            }
        }
    }
}


#Preview {
    ColorCardView()
}
