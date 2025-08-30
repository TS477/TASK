//
//  SwiftUIGesture.swift
//  Demo
//
//  Created by TSOvO on 30/8/2025.
//

import SwiftUI

struct SwiftUIGesture: View {
    @State private var isClicked: Bool = false
    @GestureState private var isLongPressed: Bool = false
    
    @GestureState private var location: CGSize = CGSize.zero
    @State private var finalLocation: CGSize = CGSize.zero
    
    @GestureState private var scaleRatio: CGFloat = CGFloat(1)
    @State private var finalScaleRatio: CGFloat = CGFloat(1)
    
    @GestureState private var rotationAngle: Angle = .zero
    @State private var finalRotationAngle: Angle = .zero
    
    
    
    var body: some View {
        /*
        Text(isClicked ? "做得好" : "點擊我")
            .font(.system(size: 28))
            .padding()
            .background(.gray)
            .cornerRadius(10)
            .padding()
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        self.isClicked.toggle()
                    }
            )
        
        Image(systemName: "heart.fill")
            .font(.system(size: 32))
            .foregroundColor(isLongPressed ? .red : .black)
            .padding()
            .background(isLongPressed ? .red.opacity(0.2) : .black.opacity(0.2))
            .cornerRadius(10)
            .padding()
            .gesture(
                LongPressGesture(maximumDistance: 1)
                    .updating(self.$isLongPressed) { value, state, _ in
                        state = value
                    }
                    
                    .onEnded { _ in
                        
                    }
            )
        
        Text("移動我")
            .font(.system(size: 28))
            .padding()
            .background(.gray)
            .cornerRadius(10)
            .padding()
            .offset(
                x: finalLocation.width + location.width,
                y: finalLocation.height + location.height
            )
            .animation(
                .easeInOut(duration: 0.2),
                value: location
            )
            .padding()
            .gesture(
                DragGesture()
                    .updating(self.$location) { value, state, _ in
                        state = value.translation
                    }
                
                    .onEnded({ value in
                        finalLocation.width += value.translation.width
                        finalLocation.height += value.translation.height
                    })
            )
        
        */
        
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 38)
            .padding()
            .background(.gray)
            .cornerRadius(10)
            .scaleEffect(finalScaleRatio * scaleRatio)
            .rotationEffect(rotationAngle + finalRotationAngle)
            .gesture(
                magnifyGesture.simultaneously(with: rotationGesture)
            )
    }
    
    private var magnifyGesture: some Gesture {
        MagnifyGesture()
            .updating(self.$scaleRatio) { value, state, _ in
                state = value.magnification
            }
            .onEnded({ value in
                self.finalScaleRatio *= value.magnification
            })
    }
    
    private var rotationGesture: some Gesture {
        RotateGesture()
            .updating(self.$rotationAngle) { value, state, _ in
                state = value.rotation
            }
            .onEnded { value in
                self.finalRotationAngle += value.rotation
            }
    }
}

#Preview {
    SwiftUIGesture()
}
