import Foundation

enum GoalStatus: String, Codable, CaseIterable {  // Enum for the status of a goal
    case inProgress
    case completed
    case missed
}
// Conforms to Codable for easy encoding/decoding and CaseIterable for use in Pickers
struct Goal: Identifiable, Codable, Equatable {
    var id = UUID()  // Unique identifier for the goal
    var title: String
    var description: String
    var weekNumber: Int
    var status: GoalStatus
}
