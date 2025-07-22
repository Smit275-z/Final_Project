import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [Task]
    @State private var showingAddTask = false
    @State private var editingTask: Task? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach($tasks) { $task in
                    HStack {
                        Button(action: { task.isCompleted.toggle() }) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                        }
                        Text(task.title)
                            .onTapGesture {
                                editingTask = task
                            }
                        Spacer()
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
