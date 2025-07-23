import SwiftUI

// View that displays, adds, edits, and deletes weekly goals
struct WeeklyGoalTrackerView: View {
    @Binding var goals: [Goal]
    @State private var showingAddGoal = false
    @State private var editingGoal: Goal? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(goals) { goal in  // ForEach displays all goals in the list
                    Button(action: { editingGoal = goal }) {  // Tapping a goal opens it for editing
                        VStack(alignment: .leading) {
                            Text(goal.title)
                                .font(.headline)
                            Text(goal.description)
                                .font(.subheadline)
                            Text("Week: \(goal.weekNumber)")
                                .font(.caption)
                            Text("Status: \(goal.status.rawValue.capitalized)")
                                .font(.caption)
                                .foregroundColor(goal.status == .completed ? .green : .primary)
                        }
                    }
                }
                .onDelete { offsets in
                    goals.remove(atOffsets: offsets) // swipe to delete goals
                }
            }
            .navigationTitle("Weekly Goals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddGoal = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $editingGoal) { goalToEdit in
                EditGoalView(goal: goalToEdit, goals: $goals) {
                    editingGoal = nil
                }
            }
            .sheet(isPresented: $showingAddGoal) {
                AddGoalView(goals: $goals)
            }
        }
    }
}
