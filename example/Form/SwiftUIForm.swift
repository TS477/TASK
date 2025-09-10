//
//  SwiftUIForm.swift
//  Demo
//
//  Created by TSOvO on 28/8/2025.
//

import SwiftUI

struct SwiftUIForm: View {
    @State var isOn = false
    @State var isPlay = false
    
    var options: [String] = ["AAA", "BBB", "CCC", "DDD"]
    @State var selectedOption: Int = 0
    
    @State var stepperValue: Int = 0
    
    @State var sliderValue: CGFloat = 50
    
    var body: some View {
        Form {
            Section {
                Text("第一句話：學習永無止境")
                
                Text("第二句話：程式設計需要耐心")
            }
            
            
            Section {
                Text("第三句話：每一次錯誤都是成長的機會")
                
                Text("第四句話：保持好奇，持續探索")
            }
            
            Section(
                header: Text("外觀模式"),
                footer: Text("夜間模式更顯得舒服")
            ) {
                Toggle(isOn: $isOn) {
                    Text("夜間模式")
                }
                .preferredColorScheme(isOn ? .dark : .light)
            }
            
            Section(
                header: Text("播放音樂"),
                footer: Text("按下即可播放一段音樂")
            ) {
                Toggle(isOn: $isPlay) {
                    Text("播放音樂")
                }
                .onChange(of: isPlay) {
                    if isPlay {
                        print("播放音樂")
                    } else {
                        print("停止音樂")
                    }
                }
            }
            
            Picker("Select an option", selection: $selectedOption) {
                ForEach(0..<options.count, id: \.self) {
                    Text(self.options[$0])
                }
            }
            .pickerStyle(.wheel)
            
            Stepper(
                "步數: \(self.stepperValue)",
                value: $stepperValue,
                in: 12...72,
                step: 1
            )
            
            Slider(
                value: $sliderValue,
                in: 0...10,
                step: 1
            )
        }
    }
}

#Preview {
    SwiftUIForm()
}
