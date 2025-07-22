import SwiftUI

struct WeeklyGoalTrackerView: View {
    @State private var goals: [Goal] = [
        Goal(title: "Exercise 3 times", description: "Go to gym or run at least 3 times this week.", weekNumber: 30, status: .inProgress)
    ]
    @State private var showingAddGoal = false

    var body: some View {
        NavigationView {
            List {
                ForEach(goals) { goal in
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
                .onDelete { offsets in
                    goals.remove(atOffsets: offsets)
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
            .sheet(isPresented: $showingAddGoal) {
                AddGoalView(goals: $goals)
            }
        }
    }
}
