import SwiftUI

struct EditTaskView: View {
    var task: Task
    @Binding var tasks: [Task]
    var dismiss: () -> Void

    @State private var title: String
    @State private var notes: String

    init(task: Task, tasks: Binding<[Task]>, dismiss: @escaping () -> Void) {
        self.task = task
        self._tasks = tasks
        self.dismiss = dismiss
        _title = State(initialValue: task.title)
        _notes = State(initialValue: task.notes ?? "")
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                TextField("Notes (optional)", text: $notes)
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                            tasks[index].title = title
                            tasks[index].notes = notes.isEmpty ? nil : notes
                        }
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
