import Foundation

enum TaskStatus: String, Codable, CaseIterable {
    case pending, completed
}

struct Task: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var notes: String?
    var isCompleted: Bool
    
    // Computed property to get the status as a TaskStatus enum
        var status: TaskStatus {
            isCompleted ? .completed : .pending
        }
}
