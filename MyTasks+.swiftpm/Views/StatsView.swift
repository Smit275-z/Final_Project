import SwiftUI

struct StatsView: View {
    let tasks: [Task]

    var body: some View {
        VStack(spacing: 24) {
            Text("Task Completion Stats")
                .font(.title2)
                .bold()

            // Use the generic percentage function for completed tasks
            Text("Completed: \(String(format: "%.1f", percentage(of: tasks) { $0.isCompleted }))%")
                .font(.headline)
                .foregroundColor(.green)
                .padding()

            // Show a progress bar for completed tasks
            ProgressView(value: percentage(of: tasks) { $0.isCompleted } / 100)
                .padding(.horizontal, 40)

            Spacer()
        }
        .padding()
    }
}

// Generic function for calculating percentage based on a predicate
func percentage<T>(of items: [T], where predicate: (T) -> Bool) -> Double {
    guard !items.isEmpty else { return 0 }
    let count = items.filter(predicate).count
    return (Double(count) / Double(items.count)) * 100
}
