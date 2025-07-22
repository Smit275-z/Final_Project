import SwiftUI

struct AddTaskView: View {
    @Binding var tasks: [Task]
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var notes = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                TextField("Notes (optional)", text: $notes)
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newTask = Task(title: title, notes: notes.isEmpty ? nil : notes, isCompleted: false)
                        tasks.append(newTask)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
