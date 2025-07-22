import SwiftUI

struct TaskListView: View {
    @State private var tasks: [Task] = []
    @State private var showingAddTask = false
    @State private var editingTask: Task? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    Button(action: { editingTask = task }) {
                        HStack {
                            Text(task.title)
                            Spacer()
                            if task.isCompleted {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("MyTasks+")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $editingTask) { taskToEdit in
                EditTaskView(task: taskToEdit, tasks: $tasks, dismiss: { editingTask = nil })
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(tasks: $tasks)
            }
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
