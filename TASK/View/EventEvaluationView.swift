import SwiftUI

// 數據模型
struct Activity: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let date: Date
    let participants: [Student]
}

struct Student: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let avatar: String
}

struct TeacherComment {
    let content: String
    let rating: Int
    let date: Date
}

struct PeerReview: Identifiable, Equatable {
    let id = UUID()
    let toStudent: Student
    var rating: Int
    var comment: String
    
    // 實現 Equatable 協議
    static func == (lhs: PeerReview, rhs: PeerReview) -> Bool {
        lhs.id == rhs.id &&
        lhs.toStudent.id == rhs.toStudent.id &&
        lhs.rating == rhs.rating &&
        lhs.comment == rhs.comment
    }
}

// 主視圖
struct EventEvaluationView: View {
    let activity: Activity
    @State private var teacherComment = TeacherComment(
        content: "同學們在本次團隊建立中表現得非常出色，展現了良好的協作精神和創新能力。特別是小組討論環節，大家積極參與，提出了許多有價值的建議。",
        rating: 4,
        date: Date()
    )
    @State private var peerReviews: [PeerReview] = []
    @State private var expandedSections: Set<String> = ["activity", "teacher"]
    @State private var editingReview: PeerReview?
    @State private var showReviewEditor = false
    
    init(activity: Activity) {
        self.activity = activity
        // 初始化互評數據
        _peerReviews = State(initialValue: generateInitialReviews(for: activity.participants))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 活動信息部分
                DisclosureGroup(isExpanded: Binding(
                    get: { expandedSections.contains("activity") },
                    set: { if $0 { expandedSections.insert("activity") } else { expandedSections.remove("activity") } }
                )) {
                    EventInfoSection(activity: activity)
                } label: {
                    SectionHeader(title: "活動信息", systemImage: "info.circle")
                }
                .padding(.horizontal)
                
                // 老師評語部分
                DisclosureGroup(isExpanded: Binding(
                    get: { expandedSections.contains("teacher") },
                    set: { if $0 { expandedSections.insert("teacher") } else { expandedSections.remove("teacher") } }
                )) {
                    TeacherCommentSection(comment: teacherComment)
                } label: {
                    SectionHeader(title: "老師評語", systemImage: "person.fill")
                }
                .padding(.horizontal)
                
                // 學生互評部分
                DisclosureGroup(isExpanded: Binding(
                    get: { expandedSections.contains("peer") },
                    set: { if $0 { expandedSections.insert("peer") } else { expandedSections.remove("peer") } }
                )) {
                    PeerReviewSection(
                        participants: activity.participants,
                        reviews: $peerReviews,
                        editingReview: $editingReview,
                        showReviewEditor: $showReviewEditor
                    )
                } label: {
                    SectionHeader(title: "學生互評", systemImage: "person.3.fill")
                }
                .padding(.horizontal)
                
                // 提交按鈕
                SubmitButton(completedCount: completedReviewsCount, totalCount: activity.participants.count - 1) {
                    submitAllReviews()
                }
                .padding()
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $showReviewEditor) {
            if let review = editingReview {
                ReviewEditorView(
                    review: review,
                    reviews: $peerReviews,
                    isPresented: $showReviewEditor
                )
            }
        }
        .onChange(of: editingReview) { newValue in
            if newValue != nil {
                showReviewEditor = true
            }
        }
    }
    
    private var completedReviewsCount: Int {
        peerReviews.filter { !$0.comment.isEmpty && $0.rating > 0 }.count
    }
    
    private func submitAllReviews() {
        print("提交所有評價數據: \(peerReviews)")
        // 這裡可以添加提交到服務器的邏輯
    }
}

// 活動信息部分
struct EventInfoSection: View {
    let activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(activity.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("活動日期: \(formatDate(activity.date))")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(activity.description)
                .font(.body)
                .lineSpacing(6)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            
            // 參與學生
            VStack(alignment: .leading, spacing: 12) {
                Text("參與學生 (\(activity.participants.count)人)")
                    .font(.headline)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                    ForEach(activity.participants) { student in
                        StudentAvatarView(student: student, showName: true)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: date)
    }
}

// 老師評語部分
struct TeacherCommentSection: View {
    let comment: TeacherComment
    
    var body: some View {
        VStack(spacing: 16) {
            // 評分
            HStack {
                Text("老師評分:")
                    .font(.headline)
                
                Spacer()
                
                StarRatingView(rating: .constant(comment.rating), interactive: false)
                    .font(.title3)
            }
            
            // 評語內容
            VStack(alignment: .leading, spacing: 8) {
                Text("評語內容:")
                    .font(.headline)
                
                Text(comment.content)
                    .font(.body)
                    .lineSpacing(6)
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(10)
            }
            
            // 評語日期
            Text("評語日期: \(formatDate(comment.date))")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        return formatter.string(from: date)
    }
}

// 學生互評部分
struct PeerReviewSection: View {
    let participants: [Student]
    @Binding var reviews: [PeerReview]
    @Binding var editingReview: PeerReview?
    @Binding var showReviewEditor: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Text("請為以下同學評分（共需要評價 \(participants.count - 1) 位同學）")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            ForEach(participants) { student in
                // 不顯示自己（假設第一個學生是自己）
                if student.id != participants.first?.id {
                    StudentReviewRow(
                        student: student,
                        review: getReview(for: student),
                        onEdit: {
                            if let existingReview = getReview(for: student) {
                                editingReview = existingReview
                            } else {
                                editingReview = PeerReview(
                                    toStudent: student,
                                    rating: 0,
                                    comment: ""
                                )
                            }
                        }
                    )
                }
            }
            
            ProgressView(value: Double(completedReviewsCount), total: Double(participants.count - 1))
                .accentColor(completedReviewsCount == participants.count - 1 ? .green : .blue)
                .padding(.vertical, 8)
            
            Text("已完成 \(completedReviewsCount)/\(participants.count - 1)")
                .font(.caption)
                .foregroundColor(completedReviewsCount == participants.count - 1 ? .green : .secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
    
    private func getReview(for student: Student) -> PeerReview? {
        reviews.first { $0.toStudent.id == student.id }
    }
    
    private var completedReviewsCount: Int {
        reviews.filter { !$0.comment.isEmpty && $0.rating > 0 }.count
    }
}

// 學生評價行
struct StudentReviewRow: View {
    let student: Student
    let review: PeerReview?
    let onEdit: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            StudentAvatarView(student: student, showName: false)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(student.name)
                    .font(.headline)
                
                if let review = review, review.rating > 0 {
                    HStack {
                        StarRatingView(rating: .constant(review.rating), interactive: false)
                            .font(.caption)
                        
                        if !review.comment.isEmpty {
                            Image(systemName: "text.bubble")
                                .foregroundColor(.green)
                                .font(.caption)
                        }
                    }
                } else {
                    Text("尚未評價")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button(action: onEdit) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

// 評價編輯器
struct ReviewEditorView: View {
    let review: PeerReview
    @Binding var reviews: [PeerReview]
    @Binding var isPresented: Bool
    @State private var rating: Int
    @State private var comment: String
    
    init(review: PeerReview, reviews: Binding<[PeerReview]>, isPresented: Binding<Bool>) {
        self.review = review
        self._reviews = reviews
        self._isPresented = isPresented
        _rating = State(initialValue: review.rating)
        _comment = State(initialValue: review.comment)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        StudentAvatarView(student: review.toStudent, showName: true)
                        Spacer()
                    }
                }
                
                Section("評分（1-5星）") {
                    StarRatingView(rating: $rating, interactive: true)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section("評語") {
                    TextEditor(text: $comment)
                        .frame(height: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
            }
            .navigationTitle("評價 \(review.toStudent.name)")
            .navigationBarItems(
                leading: Button("取消") {
                    isPresented = false
                },
                trailing: Button("保存") {
                    saveReview()
                    isPresented = false
                }
            )
        }
    }
    
    private func saveReview() {
        if let index = reviews.firstIndex(where: { $0.id == review.id }) {
            // 更新現有評價
            reviews[index].rating = rating
            reviews[index].comment = comment
        } else {
            // 添加新評價
            let newReview = PeerReview(
                toStudent: review.toStudent,
                rating: rating,
                comment: comment
            )
            reviews.append(newReview)
        }
    }
}

// 學生頭像視圖
struct StudentAvatarView: View {
    let student: Student
    let showName: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: student.avatar)
                .font(.system(size: 30))
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .background(Circle().fill(Color.gray.opacity(0.2)))
            
            if showName {
                Text(student.name)
                    .font(.caption)
                    .lineLimit(1)
            }
        }
    }
}

// 星星評分組件
struct StarRatingView: View {
    @Binding var rating: Int
    let interactive: Bool
    let size: CGFloat
    
    init(rating: Binding<Int>, interactive: Bool = true, size: CGFloat = 24) {
        self._rating = rating
        self.interactive = interactive
        self.size = size
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(star <= rating ? .yellow : .gray)
                    .font(.system(size: size))
                    .onTapGesture {
                        if interactive {
                            rating = star
                        }
                    }
            }
        }
    }
}

// 部分標題
struct SectionHeader: View {
    let title: String
    let systemImage: String
    
    var body: some View {
        HStack {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

// 提交按鈕
struct SubmitButton: View {
    let completedCount: Int
    let totalCount: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if completedCount == totalCount {
                    Image(systemName: "checkmark.circle.fill")
                }
                
                Text(completedCount == totalCount ? "提交所有評價" : "完成 \(completedCount)/\(totalCount) 後提交")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(completedCount == totalCount ? Color.green : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .disabled(completedCount != totalCount)
    }
}

// 輔助函數
func generateInitialReviews(for students: [Student]) -> [PeerReview] {
    var reviews: [PeerReview] = []
    // 跳過第一個學生（自己）
    for student in students.dropFirst() {
        reviews.append(PeerReview(
            toStudent: student,
            rating: 0,
            comment: ""
        ))
    }
    return reviews
}

// 範例數據 ///////////////////
let sampleActivity = Activity(
    name: "團隊建立活動",
    description: "本次團隊建設活動旨在增強團隊凝聚力，通過一系列協作遊戲和討論環節，促進成員之間的溝通與理解。活動包括破冰遊戲、小組討論、團隊挑戰等環節。",
    date: Date(),
    participants: [
        Student(name: "1", avatar: "person.circle.fill"),
        Student(name: "2", avatar: "person.circle.fill"),
        Student(name: "3", avatar: "person.circle.fill"),
        Student(name: "4", avatar: "person.circle.fill"),
        Student(name: "5", avatar: "person.circle.fill")
    ]
)

// 預覽
struct ActivityEvaluationView_Previews: PreviewProvider {
    static var previews: some View {
        EventEvaluationView(activity: sampleActivity)
    }
}
