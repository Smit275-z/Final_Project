import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [Task]
    @State private var showingAddTask = false
    @State private var editingTask: Task? = nil
    @State private var taskToDelete: IndexSet?
    @State private var showDeleteAlert = false

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
                .onDelete { offsets in
                    taskToDelete = offsets
                    showDeleteAlert = true
                }
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
            .alert("Delete Task?", isPresented: $showDeleteAlert, actions: {
                Button("Delete", role: .destructive) {
                    if let offsets = taskToDelete {
                        tasks.remove(atOffsets: offsets)
                    }
                    taskToDelete = nil
                }
                Button("Cancel", role: .cancel) {
                    taskToDelete = nil
                }
            }, message: {
                Text("Are you sure you want to delete this task?")
            })
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
