//
//  ChatView.swift
//  TASK
//
//  Created by Yi Fong Chan on 19/10/2025.
//

import SwiftUI
import AVFoundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
    let isAudioMessage: Bool
    let audioDuration: String?
    
    init(text: String, isFromUser: Bool, isAudioMessage: Bool = false, audioDuration: String? = nil) {
        self.text = text
        self.isFromUser = isFromUser
        self.isAudioMessage = isAudioMessage
        self.audioDuration = audioDuration
    }
}

struct ChatView: View {
    @State private var messages: [Message] = [
        Message(text: "Hello!", isFromUser: false),
        Message(text: "Hi there!", isFromUser: true)
    ]
    @State private var newMessageText = ""
    @State private var showAttachmentMenu = false
    @State private var isRecording = false
    @State private var showRecordingUI = false
    @State private var recordingTime = 0
    @State private var recordingTimer: Timer?
    
    // 用於返回按鈕
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部導航欄
            HStack {
                // 返回按鈕 - 最左邊
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.blue)
                        .frame(width: 44, height: 44)
                }
                
                // 頭像
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                
                // 姓名
                VStack(alignment: .leading, spacing: 2) {
                    Text("用戶姓名")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("在線")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .padding(.leading, 8)
                
                Spacer()
                
                // 右側通話和視訊按鈕
                HStack(spacing: 16) {
                    // 視訊通話按鈕
                    Button(action: {
                        startVideoCall()
                    }) {
                        Image(systemName: "video")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                            .frame(width: 44, height: 44)
                    }
                    
                    // 語音通話按鈕
                    Button(action: {
                        startVoiceCall()
                    }) {
                        Image(systemName: "phone")
                            .font(.system(size: 18))
                            .foregroundColor(.blue)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            .overlay(
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(Color(.separator)),
                alignment: .bottom
            )
            
            // 消息列表
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isFromUser {
                                Spacer()
                                if message.isAudioMessage {
                                    AudioMessageBubble(duration: message.audioDuration ?? "0:00", isFromUser: true)
                                } else {
                                    Text(message.text)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                            } else {
                                if message.isAudioMessage {
                                    AudioMessageBubble(duration: message.audioDuration ?? "0:00", isFromUser: false)
                                } else {
                                    Text(message.text)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.primary)
                                        .cornerRadius(12)
                                }
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            
            // 錄音UI
            if showRecordingUI {
                recordingView()
                    .transition(.opacity)
            }
            
            // 附件選單 - 放在輸入區域上方
            if showAttachmentMenu {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 0.5)
                    
                    HStack(spacing: 40) {
                        // 相機按鈕
                        Button(action: {
                            openCamera()
                            hideAttachmentMenu()
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: "camera")
                                    .font(.system(size: 24))
                                    .foregroundColor(.blue)
                                    .frame(width: 50, height: 50)
                                    .background(Color.blue.opacity(0.1))
                                    .clipShape(Circle())
                                
                                Text("相機")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        // 相片按鈕
                        Button(action: {
                            openPhotoLibrary()
                            hideAttachmentMenu()
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: "photo")
                                    .font(.system(size: 24))
                                    .foregroundColor(.green)
                                    .frame(width: 50, height: 50)
                                    .background(Color.green.opacity(0.1))
                                    .clipShape(Circle())
                                
                                Text("相片")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        // 文件按鈕
                        Button(action: {
                            openDocumentPicker()
                            hideAttachmentMenu()
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: "doc")
                                    .font(.system(size: 24))
                                    .foregroundColor(.orange)
                                    .frame(width: 50, height: 50)
                                    .background(Color.orange.opacity(0.1))
                                    .clipShape(Circle())
                                
                                Text("文件")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(Color(.systemBackground))
                }
                .transition(.move(edge: .bottom))
            }
            
            // 輸入區域
            HStack {
                // 加號按鈕 - 最左邊
                Button(action: {
                    withAnimation(.spring()) {
                        showAttachmentMenu.toggle()
                    }
                }) {
                    Image(systemName: showAttachmentMenu ? "xmark.circle.fill" : "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
                .padding(.leading)
                
                // 文字輸入框（始終顯示）
                TextField("輸入消息...", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 8)
                
                // 錄音按鈕 - 在輸入框右邊，傳送鍵左邊
                if newMessageText.isEmpty {
                    Button(action: {
                        startRecording()
                    }) {
                        Image(systemName: "mic.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 8)
                }
                
                // 傳送按鈕
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
                .padding(.trailing)
                .disabled(newMessageText.isEmpty)
            }
            .padding(.vertical, 8)
            .padding(.bottom, 8)
            .background(Color(.systemBackground))
        }
        .navigationBarHidden(true)
        .onTapGesture {
            // 點擊空白處收起附件選單
            if showAttachmentMenu {
                withAnimation(.spring()) {
                    showAttachmentMenu = false
                }
            }
        }
    }
    
    // 錄音UI視圖
    private func recordingView() -> some View {
        VStack {
            HStack {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "mic.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.red)
                    
                    Text("錄音中... \(formatTime(recordingTime))")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("鬆開手指結束錄音")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.vertical, 30)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(radius: 10)
            .padding(.horizontal, 40)
            
            Button("取消錄音") {
                cancelRecording()
            }
            .foregroundColor(.red)
            .padding(.top, 10)
        }
        .background(Color.black.opacity(0.4))
        .onTapGesture {
            // 點擊錄音UI外部結束錄音
            stopRecording()
        }
    }
    
    // 音訊消息氣泡
    struct AudioMessageBubble: View {
        let duration: String
        let isFromUser: Bool
        
        var body: some View {
            HStack(spacing: 12) {
                if isFromUser {
                    Text(duration)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Button(action: {
                        // 播放音訊
                        playAudio()
                    }) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                } else {
                    Button(action: {
                        // 播放音訊
                        playAudio()
                    }) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                    }
                    
                    Text(duration)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(isFromUser ? Color.blue : Color.gray.opacity(0.2))
            .cornerRadius(12)
        }
        
        private func playAudio() {
            print("播放音訊，時長: \(duration)")
            // 在這裡實現音訊播放邏輯
        }
    }
    
    private func sendMessage() {
        guard !newMessageText.isEmpty else { return }
        
        let newMessage = Message(text: newMessageText, isFromUser: true)
        messages.append(newMessage)
        newMessageText = ""
    }
    
    private func hideAttachmentMenu() {
        withAnimation(.spring()) {
            showAttachmentMenu = false
        }
    }
    
    // 錄音功能
    private func startRecording() {
        withAnimation(.spring()) {
            isRecording = true
            showRecordingUI = true
            recordingTime = 0
        }
        
        // 開始計時器
        recordingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            recordingTime += 1
        }
        
        // 在這裡實現開始錄音的邏輯
        print("開始錄音")
    }
    
    private func stopRecording() {
        recordingTimer?.invalidate()
        recordingTimer = nil
        
        withAnimation(.spring()) {
            isRecording = false
            showRecordingUI = false
        }
        
        // 發送音訊消息
        let durationString = formatTime(recordingTime)
        let audioMessage = Message(
            text: "音訊消息",
            isFromUser: true,
            isAudioMessage: true,
            audioDuration: durationString
        )
        messages.append(audioMessage)
        
        print("結束錄音，時長: \(durationString)")
        // 在這裡實現停止錄音和保存音訊的邏輯
    }
    
    private func cancelRecording() {
        recordingTimer?.invalidate()
        recordingTimer = nil
        
        withAnimation(.spring()) {
            isRecording = false
            showRecordingUI = false
        }
        
        print("取消錄音")
        // 在這裡實現取消錄音的邏輯
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
    // 通話功能
    private func startVoiceCall() {
        print("開始語音通話")
        // 在這裡實現語音通話邏輯
    }
    
    private func startVideoCall() {
        print("開始視訊通話")
        // 在這裡實現視訊通話邏輯
    }
    
    // 附件功能
    private func openCamera() {
        print("打開相機")
        // 在這裡實現相機功能
    }
    
    private func openPhotoLibrary() {
        print("打開相簿")
        // 在這裡實現相簿選擇功能
    }
    
    private func openDocumentPicker() {
        print("打開文件選擇器")
        // 在這裡實現文件選擇功能
    }
}

#Preview {
    ChatView()
}
