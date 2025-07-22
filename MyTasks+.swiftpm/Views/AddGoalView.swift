import SwiftUI

struct AddGoalView: View {
    @Binding var goals: [Goal]
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var description = ""
    @State private var weekNumber = Calendar.current.component(.weekOfYear, from: Date())
    @State private var status: GoalStatus = .inProgress

    var body: some View {
        NavigationView {
            Form {
                TextField("Goal Title", text: $title)
                TextField("Description", text: $description)
                Stepper("Week: \(weekNumber)", value: $weekNumber, in: 1...52)
                Picker("Status", selection: $status) {
                    ForEach(GoalStatus.allCases, id: \.self) { status in
                        Text(status.rawValue.capitalized).tag(status)
                    }
                }
            }
            .navigationTitle("Add Goal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newGoal = Goal(title: title, description: description, weekNumber: weekNumber, status: status)
                        goals.append(newGoal)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
