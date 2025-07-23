import SwiftUI

struct AddGoalView: View {
    @Binding var goals: [Goal]  // Binding to the list of goals (so this view can update it)
    @Environment(\.dismiss) var dismiss   // Used to dismiss the modal sheet

    
    //  Properties to hold the new goal's info while user is entering data
    @State private var title = ""
    @State private var description = ""
    @State private var weekNumber = Calendar.current.component(.weekOfYear, from: Date())  // Defaults to current week
    @State private var status: GoalStatus = .inProgress

    var body: some View {
        NavigationView {
            Form {   // Inputs
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
                ToolbarItem(placement: .navigationBarLeading) {    // Cancel button to close without saving
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {   // Save button to add new goal to array
                    Button("Save") {
                        let newGoal = Goal(title: title, description: description, weekNumber: weekNumber, status: status)
                        goals.append(newGoal)
                        dismiss()
                    }
                    .disabled(title.isEmpty)   // Disable save if title is empty
                }
            }
        }
    }
}
