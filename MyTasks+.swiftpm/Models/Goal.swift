import Foundation

enum GoalStatus: String, Codable, CaseIterable {
    case inProgress
    case completed
    case missed
}

struct Goal: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var weekNumber: Int
    var status: GoalStatus
}
