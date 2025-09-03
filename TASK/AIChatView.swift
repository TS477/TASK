import SwiftUI
import OpenAI

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let timestamp: Date
    
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        lhs.id == rhs.id
    }
}

struct AIChatView: View {
    @State private var messages: [ChatMessage] = []
    @State private var inputText: String = ""
    @State private var isWaitingForResponse: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @State private var scrollToBottom: Bool = false
    
    // 用於滾動到最新消息
    @Namespace private var bottomID
    
    var body: some View {
        VStack(spacing: 0) {
            // 消息列表
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                        }
                        
                        // 加載指示器
                        if isWaitingForResponse {
                            HStack {
                                ThinkingAnimation()
                                    .padding(12)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(18)
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        
                        // 底部錨點，用於自動滾動
                        Color.clear
                            .frame(height: 1)
                            .id(bottomID)
                    }
                    .padding(.vertical)
                }
                .onChange(of: messages.count) { _ in
                    scrollToBottom(proxy: proxy)
                }
                .onChange(of: isWaitingForResponse) { _ in
                    scrollToBottom(proxy: proxy)
                }
            }
            
            // 輸入區域
            InputArea(
                inputText: $inputText,
                isWaitingForResponse: isWaitingForResponse,
                isTextFieldFocused: _isTextFieldFocused,
                onSend: sendMessage
            )
        }
        .navigationTitle("AI助手")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            addWelcomeMessage()
        }
    }
    
    private func sendMessage() {
        let trimmedText = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty, !isWaitingForResponse else { return }
        
        // 添加用戶消息
        let userMessage = ChatMessage(text: trimmedText, isUser: true, timestamp: Date())
        messages.append(userMessage)
        
        // 清空輸入框
        inputText = ""
        isTextFieldFocused = false
        isWaitingForResponse = true
        
        // 調用AI API
        AIModel.sendMessage(question: trimmedText) { response in
            DispatchQueue.main.async {
                let aiMessage = ChatMessage(text: response, isUser: false, timestamp: Date())
                messages.append(aiMessage)
                isWaitingForResponse = false
            }
        }
    }
    
    private func addWelcomeMessage() {
        let welcomeMessage = ChatMessage(
            text: "您好！我是AI助手，有什麼可以幫您的嗎？",
            isUser: false,
            timestamp: Date()
        )
        messages.append(welcomeMessage)
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        withAnimation(.easeOut(duration: 0.3)) {
            proxy.scrollTo(bottomID, anchor: .bottom)
        }
    }
}

// 輸入區域組件
struct InputArea: View {
    @Binding var inputText: String
    let isWaitingForResponse: Bool
    @FocusState var isTextFieldFocused: Bool
    let onSend: () -> Void
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            TextField("輸入訊息...", text: $inputText, axis: .vertical)
                .focused($isTextFieldFocused)
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(20)
                .lineLimit(1...4)
                .submitLabel(.send)
                .onSubmit {
                    if !inputText.isEmpty && !isWaitingForResponse {
                        onSend()
                    }
                }
            
            Button(action: onSend) {
                if isWaitingForResponse {
                    ProgressView()
                        .tint(.white)
                        .padding(8)
                } else {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 32))
                }
            }
            .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isWaitingForResponse)
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(canSend ? Color.blue : Color.gray.opacity(0.5))
                    .frame(width: 36, height: 36)
            )
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
    }
    
    private var canSend: Bool {
        !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isWaitingForResponse
    }
}

// 消息氣泡組件
struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer(minLength: 50)
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(message.isUser ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(message.isUser ? .white : .primary)
                    .cornerRadius(18)
                    .textSelection(.enabled) // 允許選擇文本
                
                Text(formatTime(message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            if !message.isUser {
                Spacer(minLength: 50)
            }
        }
        .padding(.horizontal, 8)
        .transition(.opacity.combined(with: .scale))
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// 思考動畫組件
struct ThinkingAnimation: View {
    @State private var dotCount = 0
    
    var body: some View {
        HStack(spacing: 4) {
            Text("思考中")
                .foregroundColor(.gray)
            
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(index < dotCount ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 6, height: 6)
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 0.3)) {
                dotCount = (dotCount + 1) % 4
            }
        }
    }
}

// 預覽
struct AIChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AIChatView()
        }
    }
}
