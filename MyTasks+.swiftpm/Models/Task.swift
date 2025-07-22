import Foundation

enum TaskStatus: String, Codable, CaseIterable {
    case pending, completed
}

struct Task: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var notes: String?
    var isCompleted: Bool
    var status: TaskStatus {
        isCompleted ? .completed : .pending
    }
}
