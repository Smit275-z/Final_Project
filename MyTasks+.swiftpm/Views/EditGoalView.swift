import SwiftUI

// View for editing an existing goal
struct EditGoalView: View {
    var goal: Goal
    @Binding var goals: [Goal]
    var dismiss: () -> Void

// State properties
    @State private var title: String
    @State private var description: String
    @State private var weekNumber: Int
    @State private var status: GoalStatus

// Custom initializer to set initial values of state properties from the goal
    init(goal: Goal, goals: Binding<[Goal]>, dismiss: @escaping () -> Void) {
        self.goal = goal
        self._goals = goals
        self.dismiss = dismiss
        _title = State(initialValue: goal.title)
        _description = State(initialValue: goal.description)
        _weekNumber = State(initialValue: goal.weekNumber)
        _status = State(initialValue: goal.status)
    }

    var body: some View {
        NavigationView {
            Form {  // Edit Feature
                TextField("Goal Title", text: $title)
                TextField("Description", text: $description)
                Stepper("Week: \(weekNumber)", value: $weekNumber, in: 1...52)
                Picker("Status", selection: $status) {
                    ForEach(GoalStatus.allCases, id: \.self) { status in
                        Text(status.rawValue.capitalized).tag(status)
                    }
                }
            }
            .navigationTitle("Edit Goal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {  // Cancel Button
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {  // Save Button
                    Button("Save") {
                        if let index = goals.firstIndex(where: { $0.id == goal.id }) {  // Find and update the goals array
                            goals[index].title = title
                            goals[index].description = description
                            goals[index].weekNumber = weekNumber
                            goals[index].status = status
                        }
                        dismiss()
                    }
                    .disabled(title.isEmpty)  // Disable save if title is empty
                }
            }
        }
    }
}
